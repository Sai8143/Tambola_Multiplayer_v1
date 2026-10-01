import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/game_state_model.dart';
import '../models/influence_action.dart';
import '../models/player_model.dart';
import '../models/player_role.dart';
import '../models/vote_model.dart';

import '../services/firestore_service.dart';
import '../services/game_audio_service.dart';
import '../services/game_sync_service.dart';
import '../services/influence_engine.dart';
import '../services/influence_log_service.dart';
import '../services/number_queue_engine.dart';
import '../services/player_presence_service.dart';
import '../services/prediction_engine.dart';
import '../services/role_engine.dart';
import '../services/suspicion_engine.dart';
import '../services/win_validation_engine.dart';

import '../widgets/admin_control_panel.dart';
import '../widgets/chaos_meter.dart';
import '../widgets/emergency_button.dart';
import '../widgets/floating_influence_alert.dart';
import '../widgets/game_status_banner.dart';
import '../widgets/game_top_bar.dart';
import '../widgets/history_strip.dart';
import '../widgets/influence_activity_feed.dart';
import '../widgets/influence_glitch_overlay.dart';
import '../widgets/influence_panel.dart';
import '../widgets/live_players_panel.dart';
import '../widgets/number_display.dart';
import '../widgets/player_prediction_history.dart';
import '../widgets/prediction_panel.dart';
import '../widgets/round_transition_overlay.dart';
import '../widgets/suspicion_board.dart';
import '../widgets/ticket_grid.dart';
import '../widgets/upcoming_numbers_panel.dart';
import '../widgets/winning_claim_panel.dart';

import 'emergency_meeting_screen.dart';
import 'game_result_screen.dart';
import 'role_reveal_screen.dart';
import 'simple_game_screen.dart';

class GameScreen extends StatefulWidget {
  final String roomId;
  final String playerName;
  final bool isHost;
  final List<List<int?>> ticket;

  const GameScreen({
    super.key,
    required this.roomId,
    required this.playerName,
    required this.isHost,
    required this.ticket,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // SERVICES
  final FirestoreService firestoreService = FirestoreService();
  final GameSyncService syncService = GameSyncService();
  final GameAudioService audioService = GameAudioService();

  // IDS & STATE
  late String playerId;
  late PlayerModel currentPlayer;
  GameStateModel? gameState;
  StreamSubscription? gameSub;

  // NUMBER SYSTEM
  bool autoMode = false;
  bool isPaused = false;
  Timer? autoTimer;

  // UI STATE
  bool showRoundOverlay = false;
  bool showInfluenceAlert = false;
  String influenceAlertMessage = '';
  bool glitchActive = false;
  bool hasRevealedRole = false;
  bool meetingActiveLocal = false;
  bool finishedLocal = false;
  int activeDashboardTab = 0; // 0: Players & Suspicion, 1: Predictions, 2: Influence, 3: Activity Log

  // CLAIMS & PREDICTIONS
  Set<String> claimedWins = {};
  List<Map<String, dynamic>> predictionHistory = [];

  @override
  void initState() {
    super.initState();
    playerId = const Uuid().v4();
    initializePlayerAndGame();
  }

  // =========================
  // INIT PLAYER & GAME
  // =========================

  Future<void> initializePlayerAndGame() async {
    currentPlayer = PlayerModel.initial(
      playerId: playerId,
      playerName: widget.playerName,
      isHost: widget.isHost,
      ticket: widget.ticket,
    );

    await syncService.registerOrUpdatePlayer(
      roomId: widget.roomId,
      player: currentPlayer,
    );

    await PlayerPresenceService.setOnline(
      roomId: widget.roomId,
      playerId: playerId,
    );

    listenGameState();
  }

  // =========================
  // LISTENER
  // =========================

  void listenGameState() {
    gameSub = syncService.gameStream(widget.roomId).listen((state) {
      if (!mounted) return;

      setState(() {
        gameState = state;
        glitchActive = state.influenceHeat > 75;
      });

      final matchingPlayer = state.players.firstWhere(
        (p) => p.playerId == playerId,
        orElse: () => currentPlayer,
      );

      setState(() {
        currentPlayer = matchingPlayer;
      });

      // Role reveal transition
      if (state.started && !hasRevealedRole) {
        hasRevealedRole = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RoleRevealScreen(
              role: currentPlayer.role,
              onContinue: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      }

      // Emergency meeting transition
      if (state.meetingActive && !meetingActiveLocal) {
        meetingActiveLocal = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EmergencyMeetingScreen(
              players: state.players,
              currentPlayerId: playerId,
              onVote: (vote) {
                syncService.submitVote(
                  roomId: widget.roomId,
                  vote: vote,
                  currentVotes: state.meeting.votes,
                );
              },
              onMeetingEnd: () {
                syncService.endMeeting(roomId: widget.roomId);
                meetingActiveLocal = false;
                Navigator.pop(context);
              },
            ),
          ),
        ).then((_) {
          meetingActiveLocal = false;
        });
      }

      // Game finish transition
      if (state.finished && !finishedLocal) {
        finishedLocal = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => GameResultScreen(
              players: state.players,
              winners: state.players.where((p) => p.role == PlayerRole.normal).toList(),
              influencerWon: false,
              onHome: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        );
      }
    });
  }

  // =========================
  // START GAME (HOST)
  // =========================

  // =========================
  // START GAME (HOST)
  // =========================

  Future<void> startGame() async {
    if (!widget.isHost || gameState == null) return;

    final initialQueue = NumberQueueEngine.generateQueue();
    final List<PlayerModel> updatedPlayers;

    if (gameState!.gameMode == 'simple') {
      updatedPlayers = gameState!.players.map((p) => p.copyWith(role: PlayerRole.normal)).toList();
    } else {
      updatedPlayers = RoleEngine.assignRoles(gameState!.players);
    }

    await syncService.updatePlayers(
      roomId: widget.roomId,
      players: updatedPlayers,
    );

    await syncService.updateNumberQueue(
      roomId: widget.roomId,
      queue: initialQueue,
      currentNumber: null,
      calledNumbers: [],
      round: 1,
    );

    await syncService.startGame(roomId: widget.roomId);
  }

  // =========================
  // CALL NEXT NUMBER (HOST)
  // =========================

  Future<void> callNextNumber() async {
    if (!widget.isHost || gameState == null || isPaused) return;

    List<int> queue = List.from(gameState!.numberQueue);
    if (queue.isEmpty) {
      queue = NumberQueueEngine.generateQueue();
    }

    final next = NumberQueueEngine.nextNumber(queue);
    if (next == null) return;

    queue = NumberQueueEngine.consumeNumber(queue);
    final updatedCalled = [...gameState!.calledNumbers, next];
    final nextRound = gameState!.round + 1;

    await syncService.updateNumberQueue(
      roomId: widget.roomId,
      queue: queue,
      currentNumber: next,
      calledNumbers: updatedCalled,
      round: nextRound,
    );

    audioService.playNumberCall();
  }

  // =========================
  // AUTO MODE TOGGLE
  // =========================

  void toggleAutoMode() {
    if (!widget.isHost) return;

    setState(() {
      autoMode = !autoMode;
    });

    if (autoMode) {
      autoTimer = Timer.periodic(const Duration(seconds: 3), (_) {
        callNextNumber();
      });
    } else {
      autoTimer?.cancel();
    }
  }

  // =========================
  // MARK TICKET NUMBER
  // =========================

  void markNumber(int number) {
    if (currentPlayer.markedNumbers.contains(number)) return;

    final updatedMarked = [...currentPlayer.markedNumbers, number];
    final updatedPlayer = currentPlayer.copyWith(
      markedNumbers: updatedMarked,
    );

    setState(() {
      currentPlayer = updatedPlayer;
    });

    syncService.registerOrUpdatePlayer(
      roomId: widget.roomId,
      player: updatedPlayer,
    );

    audioService.playClick();
  }

  // =========================
  // SUBMIT PREDICTION
  // =========================

  void submitPrediction(String predictionType) {
    if (gameState == null || gameState!.currentNumber == null) return;

    final currentNum = gameState!.currentNumber!;
    final result = PredictionEngine.evaluatePrediction(
      prediction: predictionType,
      currentNumber: currentNum,
      markedNumbers: currentPlayer.markedNumbers,
      ticket: currentPlayer.ticket,
    );

    final scoreChange = result ? 10 : -5;
    final updatedScore = (currentPlayer.predictionScore + scoreChange).clamp(0, 9999);

    final updatedPlayer = currentPlayer.copyWith(
      predictionScore: updatedScore,
    );

    setState(() {
      currentPlayer = updatedPlayer;
      predictionHistory.insert(0, {
        'prediction': predictionType,
        'number': currentNum,
        'success': result,
        'timestamp': DateTime.now(),
      });
    });

    if (result) {
      audioService.playSuccess();
    } else {
      audioService.playFailure();
    }

    syncService.registerOrUpdatePlayer(
      roomId: widget.roomId,
      player: updatedPlayer,
    );
  }

  // =========================
  // HANDLE WINNING CLAIM
  // =========================

  Future<void> handleClaimWin(String claim) async {
    if (gameState == null) return;

    final isValid = WinValidationEngine.validateClaim(
      claimName: claim,
      ticket: currentPlayer.ticket,
      markedNumbers: currentPlayer.markedNumbers,
      calledNumbers: gameState!.calledNumbers,
    );

    if (isValid) {
      setState(() {
        claimedWins.add(claim);
      });

      audioService.playVictory();

      InfluenceLogService.addLog("🎉 ${currentPlayer.playerName} successfully claimed $claim!");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("🎉 Valid Claim! You achieved $claim!"),
          ),
        );
      }
    } else {
      audioService.playFailure();

      final updatedPlayer = SuspicionEngine.addSuspicion(currentPlayer, 15);
      setState(() {
        currentPlayer = updatedPlayer;
      });

      await syncService.registerOrUpdatePlayer(
        roomId: widget.roomId,
        player: updatedPlayer,
      );

      InfluenceLogService.addLog("⚠️ ${currentPlayer.playerName} made an INVALID claim ($claim)! Suspicion +15.");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("❌ Invalid Claim for $claim! Suspicion increased (+15)."),
          ),
        );
      }
    }
  }

  // =========================
  // TRIGGER EMERGENCY MEETING
  // =========================

  Future<void> triggerEmergencyMeeting() async {
    if (currentPlayer.emergencyMeetingsLeft <= 0) return;

    audioService.playEmergencyAlert();

    await syncService.startMeeting(
      roomId: widget.roomId,
      meeting: EmergencyMeeting.initial(),
    );

    InfluenceLogService.addLog("🚨 ${currentPlayer.playerName} called an Emergency Meeting!");
  }

  // =========================
  // USE INFLUENCE (INFLUENCER)
  // =========================

  Future<void> useInfluence(InfluenceActionType action) async {
    if (currentPlayer.role != PlayerRole.influencer || gameState == null) return;

    if (currentPlayer.influenceEnergy < action.energyCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Not enough Energy!")),
      );
      return;
    }

    final result = InfluenceEngine.applyAction(
      action: action,
      influencer: currentPlayer,
      queue: gameState!.numberQueue,
      currentHeat: gameState!.influenceHeat,
    );

    final List<int> updatedQueue = result['queue'] as List<int>;
    final int updatedHeat = result['heat'] as int;
    final PlayerModel updatedPlayer = result['player'] as PlayerModel;
    final String logMsg = result['log'] as String;

    setState(() {
      currentPlayer = updatedPlayer;
      showInfluenceAlert = true;
      influenceAlertMessage = "${action.title} Activated!";
    });

    audioService.playInfluenceSound();

    await syncService.registerOrUpdatePlayer(
      roomId: widget.roomId,
      player: updatedPlayer,
    );

    await syncService.updateNumberQueue(
      roomId: widget.roomId,
      queue: updatedQueue,
      currentNumber: gameState!.currentNumber,
      calledNumbers: gameState!.calledNumbers,
      round: gameState!.round,
    );

    await syncService.updateInfluenceHeat(
      roomId: widget.roomId,
      heat: updatedHeat,
    );

    InfluenceLogService.addLog(logMsg);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showInfluenceAlert = false;
        });
      }
    });
  }

  // =========================
  // RESET HEAT (HOST)
  // =========================

  Future<void> resetHeat() async {
    if (!widget.isHost) return;
    await syncService.updateInfluenceHeat(roomId: widget.roomId, heat: 0);
  }

  // =========================
  // LEAVE GAME
  // =========================

  void leaveGame() {
    PlayerPresenceService.setOffline(
      roomId: widget.roomId,
      playerId: playerId,
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    autoTimer?.cancel();
    gameSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (gameState == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(
          child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
        ),
      );
    }

    final state = gameState!;

    if (state.gameMode == 'simple') {
      return SimpleGameScreen(
        roomId: widget.roomId,
        playerName: widget.playerName,
        isHost: widget.isHost,
        ticket: widget.ticket,
      );
    }

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape || mediaQuery.size.width > mediaQuery.size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          SafeArea(
            left: true,
            right: true,
            top: true,
            bottom: true,
            child: isLandscape
                ? buildLandscapeLayout(context, state)
                : buildPortraitLayout(context, state),
          ),

          // OVERLAYS
          if (showInfluenceAlert)
            FloatingInfluenceAlert(
              title: influenceAlertMessage,
              description: "Room heat has increased.",
            ),
          if (showRoundOverlay) RoundTransitionOverlay(round: state.round),
          if (glitchActive) const InfluenceGlitchOverlay(active: true, child: SizedBox()),
        ],
      ),
    );
  }

  // ==========================================
  // LANDSCAPE LAYOUT (SINGLE SCREEN SPLIT VIEW)
  // ==========================================

  Widget buildLandscapeLayout(BuildContext context, GameStateModel state) {
    final isSimple = state.gameMode == 'simple';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT COLUMN: CORE GAMEPLAY (TICKET, NUMBERS, CONTROLS)
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // COMPACT TOP BAR
                  GameTopBar(
                    roomId: widget.roomId,
                    round: state.round,
                    players: state.players.length,
                    heat: state.influenceHeat,
                    calledCount: state.calledNumbers.length,
                    isAdmin: widget.isHost,
                    onExit: leaveGame,
                    gameMode: state.gameMode,
                  ),
                  const SizedBox(height: 8),

                  // CONTROLS & NUMBER ROW
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: NumberDisplay(
                          current: state.currentNumber,
                          autoMark: true,
                          onAutoMarkChanged: (_) {},
                          isAdmin: widget.isHost,
                          isInfluenced: !isSimple && state.influenceHeat > 50,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          if (widget.isHost && !state.started)
                            ElevatedButton.icon(
                              onPressed: startGame,
                              icon: const Icon(Icons.play_arrow, size: 16),
                              label: const Text("Start", style: TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                            ),
                          if (widget.isHost && state.started) ...[
                            ElevatedButton.icon(
                              onPressed: callNextNumber,
                              icon: const Icon(Icons.skip_next, size: 16),
                              label: const Text("Next", style: TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                            ),
                            const SizedBox(height: 6),
                            ElevatedButton.icon(
                              onPressed: toggleAutoMode,
                              icon: Icon(autoMode ? Icons.pause : Icons.play_arrow, size: 16),
                              label: Text(autoMode ? "Stop" : "Auto", style: const TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: autoMode ? Colors.orange : Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                            ),
                          ],
                          if (!isSimple) ...[
                            const SizedBox(height: 6),
                            EmergencyButton(onTap: triggerEmergencyMeeting, compact: true),
                          ],
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // TICKET GRID (COMPACT)
                  TicketGrid(
                    ticket: currentPlayer.ticket,
                    markedNumbers: currentPlayer.markedNumbers.toSet(),
                    onTap: markNumber,
                    compact: true,
                  ),
                  const SizedBox(height: 8),

                  // WINNING CLAIM PANEL
                  WinningClaimPanel(
                    enabled: state.started,
                    onClaim: handleClaimWin,
                    claimedWins: claimedWins,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // RIGHT COLUMN: DASHBOARD PANELS WITH TAB SWITCHER
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  // TAB SWITCHER HEADER
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: isSimple
                            ? [
                                buildTabButton(0, Icons.groups, "Players (${state.players.length})"),
                                buildTabButton(1, Icons.list_alt, "Activity"),
                              ]
                            : [
                                buildTabButton(0, Icons.groups, "Players (${state.players.length})"),
                                buildTabButton(1, Icons.psychology, "Predictions"),
                                buildTabButton(
                                  2,
                                  Icons.bolt,
                                  "Influence",
                                  isHighlight: currentPlayer.role == PlayerRole.influencer,
                                ),
                                buildTabButton(3, Icons.list_alt, "Activity"),
                              ],
                      ),
                    ),
                  ),

                  // TAB CONTENT AREA
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: buildActiveTabContent(state),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TAB BUTTON HELPER
  Widget buildTabButton(int index, IconData icon, String label, {bool isHighlight = false}) {
    final isSelected = activeDashboardTab == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: () => setState(() => activeDashboardTab = index),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isHighlight ? Colors.deepPurpleAccent : Colors.indigo)
                : (isHighlight ? Colors.deepPurple.withOpacity(0.2) : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            border: isHighlight && !isSelected ? Border.all(color: Colors.deepPurpleAccent) : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected ? Colors.white : (isHighlight ? Colors.deepPurpleAccent : Colors.grey),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : (isHighlight ? Colors.deepPurpleAccent : Colors.grey.shade400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ACTIVE TAB CONTENT BUILDER
  Widget buildActiveTabContent(GameStateModel state) {
    final isSimple = state.gameMode == 'simple';

    if (isSimple) {
      switch (activeDashboardTab) {
        case 0:
          return LivePlayersPanel(
            players: state.players,
            currentPlayerId: playerId,
          );
        case 1:
        default:
          return Column(
            children: [
              HistoryStrip(
                history: state.calledNumbers.reversed.toList(),
              ),
              const SizedBox(height: 10),
              InfluenceActivityFeed(logs: InfluenceLogService.logs),
            ],
          );
      }
    }

    switch (activeDashboardTab) {
      case 0:
        return Column(
          children: [
            ChaosMeter(heat: state.influenceHeat),
            const SizedBox(height: 10),
            LivePlayersPanel(
              players: state.players,
              currentPlayerId: playerId,
            ),
            const SizedBox(height: 10),
            SuspicionBoard(
              players: state.players,
              currentPlayerId: playerId,
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            PredictionPanel(onPredict: submitPrediction),
            const SizedBox(height: 10),
            PlayerPredictionHistory(history: predictionHistory),
          ],
        );
      case 2:
        return Column(
          children: [
            UpcomingNumbersPanel(
              upcomingNumbers: NumberQueueEngine.upcomingPreview(state.numberQueue, 5),
              visible: currentPlayer.role == PlayerRole.influencer,
              isInfluencer: currentPlayer.role == PlayerRole.influencer,
            ),
            const SizedBox(height: 10),
            if (currentPlayer.role == PlayerRole.influencer)
              InfluencePanel(
                energy: currentPlayer.influenceEnergy,
                onAction: useInfluence,
              )
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.indigo.withOpacity(0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.security, color: Colors.indigoAccent, size: 36),
                    SizedBox(height: 8),
                    Text(
                      "You are a Normal Player",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Stay alert! An Influencer in this room is secretly manipulating the number queue.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
          ],
        );
      case 3:
      default:
        return Column(
          children: [
            HistoryStrip(
              history: state.calledNumbers.reversed.toList(),
            ),
            const SizedBox(height: 10),
            InfluenceActivityFeed(logs: InfluenceLogService.logs),
          ],
        );
    }
  }

  // ==========================================
  // PORTRAIT LAYOUT (VERTICAL SCROLL VIEW)
  // ==========================================

  Widget buildPortraitLayout(BuildContext context, GameStateModel state) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final isSimple = state.gameMode == 'simple';

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 12 : 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Column(
            children: [
              // TOP BAR
              GameTopBar(
                roomId: widget.roomId,
                round: state.round,
                players: state.players.length,
                heat: state.influenceHeat,
                calledCount: state.calledNumbers.length,
                isAdmin: widget.isHost,
                onExit: leaveGame,
                gameMode: state.gameMode,
              ),
              const SizedBox(height: 14),

              // ADMIN CONTROL PANEL (HOST ONLY)
              if (widget.isHost)
                AdminControlPanel(
                  gameStarted: state.started,
                  gamePaused: isPaused,
                  currentRound: state.round,
                  calledNumbers: state.calledNumbers.length,
                  onStart: startGame,
                  onPause: () => setState(() => isPaused = true),
                  onResume: () => setState(() => isPaused = false),
                  onNextNumber: callNextNumber,
                  onReset: resetHeat,
                ),

              const SizedBox(height: 14),

              // STATUS BANNER
              GameStatusBanner(
                started: state.started,
                paused: isPaused,
                finished: state.finished,
                round: state.round,
              ),
              const SizedBox(height: 10),

              // CHAOS METER (COMPLEX MODE ONLY)
              if (!isSimple) ...[
                ChaosMeter(heat: state.influenceHeat),
                const SizedBox(height: 14),
              ],

              // NUMBER DISPLAY
              NumberDisplay(
                current: state.currentNumber,
                autoMark: true,
                onAutoMarkChanged: (_) {},
                isAdmin: widget.isHost,
                isInfluenced: !isSimple && state.influenceHeat > 50,
              ),
              const SizedBox(height: 18),

              // CONTROLS WRAP
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  if (widget.isHost && !state.started)
                    ElevatedButton.icon(
                      onPressed: startGame,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Start Game"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  if (widget.isHost && state.started)
                    ElevatedButton.icon(
                      onPressed: callNextNumber,
                      icon: const Icon(Icons.skip_next),
                      label: const Text("Next Number"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  if (widget.isHost && state.started)
                    ElevatedButton.icon(
                      onPressed: toggleAutoMode,
                      icon: Icon(autoMode ? Icons.pause : Icons.play_arrow),
                      label: Text(autoMode ? "Stop Auto" : "Auto Call"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: autoMode ? Colors.orange : Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  if (!isSimple) EmergencyButton(onTap: triggerEmergencyMeeting),
                ],
              ),
              const SizedBox(height: 22),

              // TICKET GRID
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TicketGrid(
                  ticket: currentPlayer.ticket,
                  markedNumbers: currentPlayer.markedNumbers.toSet(),
                  onTap: markNumber,
                ),
              ),
              const SizedBox(height: 22),

              // WINNING CLAIM PANEL
              WinningClaimPanel(
                enabled: state.started,
                onClaim: handleClaimWin,
                claimedWins: claimedWins,
              ),

              // HISTORY STRIP
              HistoryStrip(
                history: state.calledNumbers.reversed.toList(),
              ),

              // UPCOMING NUMBERS (INFLUENCER ONLY IN COMPLEX MODE)
              if (!isSimple)
                UpcomingNumbersPanel(
                  upcomingNumbers: NumberQueueEngine.upcomingPreview(state.numberQueue, 5),
                  visible: currentPlayer.role == PlayerRole.influencer,
                  isInfluencer: currentPlayer.role == PlayerRole.influencer,
                ),

              // LIVE PLAYERS PANEL
              LivePlayersPanel(
                players: state.players,
                currentPlayerId: playerId,
              ),

              // PREDICTION & SUSPICION & INFLUENCE (COMPLEX MODE ONLY)
              if (!isSimple) ...[
                PredictionPanel(onPredict: submitPrediction),
                PlayerPredictionHistory(history: predictionHistory),
                SuspicionBoard(
                  players: state.players,
                  currentPlayerId: playerId,
                ),
                if (currentPlayer.role == PlayerRole.influencer)
                  InfluencePanel(
                    energy: currentPlayer.influenceEnergy,
                    onAction: useInfluence,
                  ),
              ],

              // LOG FEED
              const SizedBox(height: 20),
              InfluenceActivityFeed(logs: InfluenceLogService.logs),
            ],
          ),
        ),
      ),
    );
  }
}
