import 'package:flutter/material.dart';

import '../models/player_model.dart';

class EmergencyMeetingDialog extends StatefulWidget {
  final List<PlayerModel> players;

  final String currentPlayerId;

  final Function(
    String targetPlayerId,
  ) onVote;

  const EmergencyMeetingDialog({
    super.key,
    required this.players,
    required this.currentPlayerId,
    required this.onVote,
  });

  static Future<void> show({
    required BuildContext context,
    required List<PlayerModel> players,
    required String currentPlayerId,
    required Function(
      String targetPlayerId,
    ) onVote,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return EmergencyMeetingDialog(
          players: players,
          currentPlayerId: currentPlayerId,
          onVote: onVote,
        );
      },
    );
  }

  @override
  State<EmergencyMeetingDialog> createState() => _EmergencyMeetingDialogState();
}

class _EmergencyMeetingDialogState extends State<EmergencyMeetingDialog> {
  String? selectedPlayerId;

  bool submitting = false;

  // =========================
  // VOTABLE PLAYERS
  // =========================

  List<PlayerModel> get votablePlayers {
    return widget.players
        .where(
          (player) =>
              !player.isEliminated && player.playerId != widget.currentPlayerId,
        )
        .toList();
  }

  // =========================
  // SUBMIT
  // =========================

  Future<void> submitVote() async {
    if (selectedPlayerId == null) {
      return;
    }

    setState(() {
      submitting = true;
    });

    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    widget.onVote(
      selectedPlayerId!,
    );

    if (mounted) {
      Navigator.pop(
        context,
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          24,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(
                0xFF1E1B4B,
              ),
              Color(
                0xFF312E81,
              ),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.35,
              ),
              blurRadius: 20,
              offset: const Offset(
                0,
                10,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================
            // HEADER
            // =====================

            Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(
                      0.15,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 34,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emergency Meeting",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Vote the suspected influencer.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 26,
            ),

            // =====================
            // PLAYERS
            // =====================

            if (votablePlayers.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  22,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.05,
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "No players available for voting.",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),

            if (votablePlayers.isNotEmpty)
              SizedBox(
                height: 340,
                child: ListView.separated(
                  itemCount: votablePlayers.length,
                  separatorBuilder: (
                    _,
                    __,
                  ) =>
                      const SizedBox(
                    height: 14,
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final player = votablePlayers[index];

                    final selected = selectedPlayerId == player.playerId;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlayerId = player.playerId;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 220,
                        ),
                        padding: const EdgeInsets.all(
                          18,
                        ),
                        decoration: BoxDecoration(
                          gradient: selected
                              ? const LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.deepPurple,
                                  ],
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(
                                      0.08,
                                    ),
                                    Colors.white.withOpacity(
                                      0.04,
                                    ),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(
                            22,
                          ),
                          border: Border.all(
                            color: selected ? Colors.white : Colors.transparent,
                            width: 1.4,
                          ),
                        ),
                        child: Row(
                          children: [
                            // =================
                            // AVATAR
                            // =================

                            CircleAvatar(
                              radius: 28,
                              backgroundColor:
                                  selected ? Colors.white : Colors.deepPurple,
                              child: Text(
                                player.playerName[0].toUpperCase(),
                                style: TextStyle(
                                  color: selected ? Colors.red : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 16,
                            ),

                            // =================
                            // INFO
                            // =================

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    player.playerName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        player.isOnline
                                            ? Icons.wifi
                                            : Icons.wifi_off,
                                        size: 16,
                                        color: player.isOnline
                                            ? Colors.greenAccent
                                            : Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        player.isOnline ? "ONLINE" : "OFFLINE",
                                        style: TextStyle(
                                          color: player.isOnline
                                              ? Colors.greenAccent
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // =================
                            // RADIO
                            // =================

                            AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      selected ? Colors.white : Colors.white38,
                                  width: 2,
                                ),
                                color: selected
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: selected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.red,
                                      size: 18,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(
              height: 24,
            ),

            // =====================
            // BUTTONS
            // =====================

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: submitting
                        ? null
                        : () {
                            Navigator.pop(
                              context,
                            );
                          },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withOpacity(
                          0.3,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: submitting || selectedPlayerId == null
                        ? null
                        : submitVote,
                    icon: submitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.how_to_vote,
                          ),
                    label: Text(
                      submitting ? "Submitting..." : "Vote",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
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
          ],
        ),
      ),
    );
  }
}
