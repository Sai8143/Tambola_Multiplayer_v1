import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/game_state_model.dart';
import '../models/player_model.dart';
import '../models/player_role.dart';

import '../services/firestore_service.dart';
import '../services/game_audio_service.dart';
import '../services/game_sync_service.dart';
import '../services/influence_log_service.dart';
import '../services/number_queue_engine.dart';
import '../services/player_presence_service.dart';
import '../services/win_validation_engine.dart';

import '../widgets/admin_control_panel.dart';
import '../widgets/game_status_banner.dart';
import '../widgets/game_top_bar.dart';
import '../widgets/history_strip.dart';
import '../widgets/influence_activity_feed.dart';
import '../widgets/live_players_panel.dart';
import '../widgets/number_display.dart';
import '../widgets/ticket_grid.dart';
import '../widgets/winning_claim_panel.dart';

import 'game_result_screen.dart';

class SimpleGameScreen extends StatefulWidget {
  final String roomId;
  final String playerName;
  final bool isHost;
  final List<List<int?>> ticket;

  const SimpleGameScreen({
    super.key,
    required this.roomId,
    required this.playerName,
    required this.isHost,
    required this.ticket,
  });

  @override
  State<SimpleGameScreen> createState() => _SimpleGameScreenState();
}

class _SimpleGameScreenState extends State<SimpleGameScreen> {
  // SERVICES
  final FirestoreService firestoreService = FirestoreService();
  final GameSyncService syncService = GameSyncService();
  final GameAudioService audioService = GameAudioService();

  // IDS & STATE
  late String playerId;
  late PlayerModel currentPlayer;
  GameStateModel? gameState;
  StreamSubscription? gameSub;

  // NUMBER SYSTEM & TIMERS
  bool autoMode = false;
  bool isPaused = false;
  Timer? autoTimer;

  // UI & CLAIMS
  bool finishedLocal = false;
  int activeDashboardTab = 0; // 0: Players, 1: History & Activity Log
  Set<String> claimedWins = {};

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
    ).copyWith(role: PlayerRole.normal);

    await syncService.registerOrUpdatePlayer(
      roomId: widget.roomId,
      player: currentPlayer,
      gameMode: 'simple',
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
      });

      final matchingPlayer = state.players.firstWhere(
        (p) => p.playerId == playerId,
        orElse: () => currentPlayer,
      );

      setState(() {
        currentPlayer = matchingPlayer;
      });

      // Game finish transition
      if (state.finished && !finishedLocal) {
        finishedLocal = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => GameResultScreen(
              players: state.players,
              winners: state.players,
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

  Future<void> startGame() async {
    if (!widget.isHost || gameState == null) return;

    final initialQueue = NumberQueueEngine.generateQueue();
    final updatedPlayers = gameState!.players
        .map((p) => p.copyWith(role: PlayerRole.normal))
        .toList();

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
      gameMode: 'simple',
    );

    audioService.playClick();
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

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("❌ Invalid Claim for $claim!"),
          ),
        );
      }
    }
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
          child: CircularProgressIndicator(color: Colors.tealAccent),
        ),
      );
    }

    final state = gameState!;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape ||
        mediaQuery.size.width > mediaQuery.size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        left: true,
        right: true,
        top: true,
        bottom: true,
        child: isLandscape
            ? buildLandscapeLayout(context, state)
            : buildPortraitLayout(context, state),
      ),
    );
  }

  // ==========================================
  // LANDSCAPE LAYOUT (SINGLE SCREEN SPLIT VIEW)
  // ==========================================

  Widget buildLandscapeLayout(BuildContext context, GameStateModel state) {
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
                  // TOP BAR
                  GameTopBar(
                    roomId: widget.roomId,
                    round: state.round,
                    players: state.players.length,
                    heat: 0,
                    calledCount: state.calledNumbers.length,
                    isAdmin: widget.isHost,
                    onExit: leaveGame,
                    gameMode: 'simple',
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
                          isInfluenced: false,
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
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              ),
                            ),
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
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F172A),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildTabButton(0, Icons.groups, "Players (${state.players.length})"),
                        buildTabButton(1, Icons.list_alt, "Activity & Called"),
                      ],
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
  Widget buildTabButton(int index, IconData icon, String label) {
    final isSelected = activeDashboardTab == index;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: InkWell(
          onTap: () => setState(() => activeDashboardTab = index),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 15,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ACTIVE TAB CONTENT BUILDER
  Widget buildActiveTabContent(GameStateModel state) {
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

  // ==========================================
  // PORTRAIT LAYOUT (VERTICAL SCROLL VIEW)
  // ==========================================

  Widget buildPortraitLayout(BuildContext context, GameStateModel state) {
    final isMobile = MediaQuery.of(context).size.width < 700;

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
                heat: 0,
                calledCount: state.calledNumbers.length,
                isAdmin: widget.isHost,
                onExit: leaveGame,
                gameMode: 'simple',
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
                  onReset: () {},
                ),

              const SizedBox(height: 14),

              // STATUS BANNER
              GameStatusBanner(
                started: state.started,
                paused: isPaused,
                finished: state.finished,
                round: state.round,
              ),
              const SizedBox(height: 14),

              // NUMBER DISPLAY
              NumberDisplay(
                current: state.currentNumber,
                autoMark: true,
                onAutoMarkChanged: (_) {},
                isAdmin: widget.isHost,
                isInfluenced: false,
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
                        backgroundColor: Colors.teal,
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
              const SizedBox(height: 14),

              // HISTORY STRIP
              HistoryStrip(
                history: state.calledNumbers.reversed.toList(),
              ),
              const SizedBox(height: 14),

              // LIVE PLAYERS PANEL
              LivePlayersPanel(
                players: state.players,
                currentPlayerId: playerId,
              ),

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
