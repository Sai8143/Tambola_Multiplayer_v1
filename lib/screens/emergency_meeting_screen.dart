import 'dart:async';

import 'package:flutter/material.dart';

import '../models/player_model.dart';
import '../models/vote_model.dart';

class EmergencyMeetingScreen extends StatefulWidget {
  final List<PlayerModel> players;

  final String currentPlayerId;

  final Function(VoteModel vote) onVote;

  final VoidCallback onMeetingEnd;

  const EmergencyMeetingScreen({
    super.key,
    required this.players,
    required this.currentPlayerId,
    required this.onVote,
    required this.onMeetingEnd,
  });

  @override
  State<EmergencyMeetingScreen> createState() => _EmergencyMeetingScreenState();
}

class _EmergencyMeetingScreenState extends State<EmergencyMeetingScreen> {
  int remainingSeconds = 45;

  Timer? timer;

  String? selectedPlayerId;

  bool voteSubmitted = false;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  // =========================
  // TIMER
  // =========================

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        if (remainingSeconds <= 1) {
          timer?.cancel();

          widget.onMeetingEnd();

          Navigator.pop(
            context,
          );

          return;
        }

        setState(() {
          remainingSeconds--;
        });
      },
    );
  }

  // =========================
  // SUBMIT VOTE
  // =========================

  void submitVote() {
    if (selectedPlayerId == null) {
      return;
    }

    final vote = VoteModel(
      voterId: widget.currentPlayerId,
      targetPlayerId: selectedPlayerId!,
    );

    widget.onVote(vote);

    setState(() {
      voteSubmitted = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          "Vote Submitted",
        ),
      ),
    );
  }

  // =========================
  // UI
  // =========================

  @override
  Widget build(
    BuildContext context,
  ) {
    final players = widget.players
        .where(
          (p) => p.playerId != widget.currentPlayerId,
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Container(
                padding: const EdgeInsets.all(
                  28,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade900,
                      Colors.black,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: Column(
                  children: [
                    // =================
                    // ICON
                    // =================

                    const Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 80,
                    ),

                    const SizedBox(height: 20),

                    // =================
                    // TITLE
                    // =================

                    const Text(
                      "Emergency Meeting",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "Vote the player you suspect is manipulating fate.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================
                    // TIMER
                    // =================

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.08,
                        ),
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                      child: Text(
                        "⏳ $remainingSeconds seconds",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // =================
                    // PLAYERS
                    // =================

                    ...players.map(
                      (player) {
                        final selected = selectedPlayerId == player.playerId;

                        return GestureDetector(
                          onTap: voteSubmitted
                              ? null
                              : () {
                                  setState(
                                    () {
                                      selectedPlayerId = player.playerId;
                                    },
                                  );
                                },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 14,
                            ),
                            padding: const EdgeInsets.all(
                              16,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? Colors.red
                                  : Colors.white.withOpacity(
                                      0.08,
                                    ),
                              borderRadius: BorderRadius.circular(
                                18,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  child: Text(
                                    player.playerName[0].toUpperCase(),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    player.playerName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (selected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // =================
                    // BUTTON
                    // =================

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: voteSubmitted ? null : submitVote,
                        icon: const Icon(
                          Icons.gavel,
                        ),
                        label: const Text(
                          "Submit Vote",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
