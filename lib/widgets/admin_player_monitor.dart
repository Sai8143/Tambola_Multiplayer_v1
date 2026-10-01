import 'package:flutter/material.dart';

class AdminPlayerMonitor extends StatelessWidget {
  final List<Map<String, dynamic>> players;

  const AdminPlayerMonitor({
    super.key,
    required this.players,
  });

  // =========================
  // ONLINE COUNT
  // =========================

  int get onlinePlayers {
    return players
        .where(
          (
            player,
          ) =>
              player['online'] == true,
        )
        .length;
  }

  // =========================
  // ELIMINATED COUNT
  // =========================

  int get eliminatedPlayers {
    return players
        .where(
          (
            player,
          ) =>
              player['eliminated'] == true,
        )
        .length;
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
                      Colors.indigo,
                      Colors.deepPurple,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.groups,
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
                      "Player Monitor",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Track player activity",
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
                  color: Colors.indigo.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "${players.length}",
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 26,
          ),

          // =====================
          // STATS
          // =====================

          Row(
            children: [
              Expanded(
                child: buildStatCard(
                  title: "Online",
                  value: onlinePlayers.toString(),
                  icon: Icons.wifi,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: buildStatCard(
                  title: "Eliminated",
                  value: eliminatedPlayers.toString(),
                  icon: Icons.cancel,
                  color: Colors.red,
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
                    Icons.groups,
                    size: 44,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "No players connected",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          // =====================
          // PLAYER LIST
          // =====================

          if (players.isNotEmpty)
            ListView.separated(
              itemCount: players.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                final player = players[index];

                final bool online = player['online'] == true;

                final bool eliminated = player['eliminated'] == true;

                final bool influencer = player['influencer'] == true;

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
                                  Colors.green.shade50,
                                  Colors.green.shade100,
                                ],
                    ),
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                    border: Border.all(
                      color: eliminated
                          ? Colors.red.shade200
                          : influencer
                              ? Colors.deepPurple.shade200
                              : Colors.green.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      // =================
                      // AVATAR
                      // =================

                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: influencer
                              ? Colors.deepPurple
                              : eliminated
                                  ? Colors.red
                                  : Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            player['name']
                                .toString()
                                .substring(
                                  0,
                                  1,
                                )
                                .toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      // =================
                      // DETAILS
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
                                  label: online ? "ONLINE" : "OFFLINE",
                                  color: online ? Colors.green : Colors.grey,
                                ),
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
                        width: 80,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            20,
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
                                fontSize: 24,
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
  // STAT CARD
  // =========================

  Widget buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        18,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(
          0.08,
        ),
        borderRadius: BorderRadius.circular(
          22,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
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
