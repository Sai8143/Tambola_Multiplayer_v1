import 'package:flutter/material.dart';

class PlayerScoreboard extends StatelessWidget {
  final List<Map<String, dynamic>> players;

  const PlayerScoreboard({
    super.key,
    required this.players,
  });

  // =========================
  // SORTED PLAYERS
  // =========================

  List<Map<String, dynamic>> get sortedPlayers {
    final copied = List<Map<String, dynamic>>.from(players);

    copied.sort(
      (
        a,
        b,
      ) =>
          (b['score'] as int).compareTo(
        a['score'] as int,
      ),
    );

    return copied;
  }

  // =========================
  // MEDAL ICON
  // =========================

  IconData getMedal(
    int index,
  ) {
    if (index == 0) {
      return Icons.emoji_events;
    }

    if (index == 1) {
      return Icons.workspace_premium;
    }

    if (index == 2) {
      return Icons.military_tech;
    }

    return Icons.stars;
  }

  // =========================
  // MEDAL COLOR
  // =========================

  Color getMedalColor(
    int index,
  ) {
    if (index == 0) {
      return Colors.amber;
    }

    if (index == 1) {
      return Colors.blueGrey;
    }

    if (index == 2) {
      return Colors.orange;
    }

    return Colors.indigo;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        top: 22,
      ),
      padding: const EdgeInsets.all(
        22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.06,
            ),
            blurRadius: 14,
            offset: const Offset(
              0,
              6,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================
          // HEADER
          // =====================

          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.deepOrange,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.leaderboard,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Player Scoreboard",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Live ranking standings",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "${players.length}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // EMPTY
          // =====================

          if (players.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 36,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.leaderboard,
                    size: 44,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "No players available",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          // =====================
          // SCORE LIST
          // =====================

          if (players.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedPlayers.length,
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
                final player = sortedPlayers[index];

                final bool influencer = player['influencer'] == true;

                final bool eliminated = player['eliminated'] == true;

                final medalColor = getMedalColor(
                  index,
                );

                return Container(
                  padding: const EdgeInsets.all(
                    18,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: eliminated
                          ? [
                              Colors.red.shade50,
                              Colors.red.shade100,
                            ]
                          : influencer
                              ? [
                                  Colors.deepPurple.shade50,
                                  Colors.red.shade50,
                                ]
                              : [
                                  Colors.orange.shade50,
                                  Colors.yellow.shade50,
                                ],
                    ),
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                    border: Border.all(
                      color: medalColor.withOpacity(
                        0.24,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // =================
                      // RANK
                      // =================

                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: medalColor,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              getMedal(
                                index,
                              ),
                              color: Colors.white,
                              size: 22,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "#${index + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      // =================
                      // PLAYER DETAILS
                      // =================

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              player['name'].toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                buildChip(
                                  label: influencer ? "INFLUENCER" : "PLAYER",
                                  color: influencer
                                      ? Colors.deepPurple
                                      : Colors.indigo,
                                ),
                                if (eliminated)
                                  buildChip(
                                    label: "ELIMINATED",
                                    color: Colors.red,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // =================
                      // SCORE
                      // =================

                      Container(
                        width: 92,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            22,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.stars,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              player['score'].toString(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // =========================
  // CHIP
  // =========================

  Widget buildChip({
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(
          0.12,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
