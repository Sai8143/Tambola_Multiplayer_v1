import 'package:flutter/material.dart';

class GameTopBar extends StatelessWidget {
  final String roomId;
  final int round;
  final int players;
  final int heat;
  final int calledCount;
  final bool isAdmin;
  final VoidCallback onExit;
  final String gameMode;

  const GameTopBar({
    super.key,
    required this.roomId,
    required this.round,
    required this.players,
    required this.heat,
    required this.calledCount,
    required this.isAdmin,
    required this.onExit,
    this.gameMode = 'complex',
  });

  bool get isSimple => gameMode == 'simple';

  Color get heatColor {
    if (heat >= 80) return Colors.red;
    if (heat >= 50) return Colors.orange;
    return Colors.green;
  }

  String get roundLabel => "Round $round";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSimple
              ? [const Color(0xFF0F766E), const Color(0xFF115E59)]
              : [const Color(0xFF1E1B4B), const Color(0xFF312E81)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // TOP ROW
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        isSimple ? Icons.casino : Icons.casino,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isSimple ? "CLASSIC TAMBOLA" : "FATE TICKETS",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Room: $roomId",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ROLE BADGE
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isAdmin
                      ? Colors.orange.withOpacity(0.15)
                      : Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isAdmin ? Colors.orange : Colors.green,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isAdmin ? Icons.admin_panel_settings : Icons.person,
                      color: isAdmin ? Colors.orange : Colors.greenAccent,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isAdmin ? "HOST" : "PLAYER",
                      style: TextStyle(
                        color: isAdmin ? Colors.orange : Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // EXIT
              IconButton(
                onPressed: onExit,
                icon: const Icon(Icons.logout, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // STATS GRID
          Row(
            children: [
              Expanded(
                child: buildStatCard(
                  title: "ROUND",
                  value: round.toString(),
                  subtitle: roundLabel,
                  icon: Icons.refresh,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildStatCard(
                  title: "PLAYERS",
                  value: players.toString(),
                  subtitle: "Active",
                  icon: Icons.groups,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildStatCard(
                  title: "CALLED",
                  value: calledCount.toString(),
                  subtitle: "/ 90",
                  icon: Icons.confirmation_number,
                  color: Colors.teal,
                ),
              ),
            ],
          ),

          if (!isSimple) ...[
            const SizedBox(height: 14),

            // HEAT SECTION (COMPLEX MODE ONLY)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, color: heatColor),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Influence Heat",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "$heat%",
                        style: TextStyle(
                          color: heatColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: heat / 100,
                      minHeight: 12,
                      backgroundColor: Colors.white12,
                      valueColor: AlwaysStoppedAnimation(heatColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          0.06,
        ),
        borderRadius: BorderRadius.circular(
          22,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(
                0.15,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
