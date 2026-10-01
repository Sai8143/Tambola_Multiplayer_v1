import 'package:flutter/material.dart';

class AdminControlPanel extends StatelessWidget {
  final bool gameStarted;

  final bool gamePaused;

  final int currentRound;

  final int calledNumbers;

  final VoidCallback onStart;

  final VoidCallback onPause;

  final VoidCallback onResume;

  final VoidCallback onNextNumber;

  final VoidCallback onReset;

  const AdminControlPanel({
    super.key,
    required this.gameStarted,
    required this.gamePaused,
    required this.currentRound,
    required this.calledNumbers,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onNextNumber,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF111827),
            Color(0xFF1F2937),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 10),
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
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.amber,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Admin Controls",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Host management suite",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: gamePaused
                      ? Colors.orange.withValues(alpha: 0.18)
                      : Colors.green.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  gamePaused ? "PAUSED" : "LIVE",
                  style: TextStyle(
                    color: gamePaused ? Colors.orangeAccent : Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // =====================
          // MATCH STATS
          // =====================
          Row(
            children: [
              Expanded(
                child: buildStatCard(
                  title: "Round",
                  value: currentRound.toString(),
                  icon: Icons.autorenew,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildStatCard(
                  title: "Numbers",
                  value: "$calledNumbers/90",
                  icon: Icons.pin,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // =====================
          // PRIMARY ACTIONS
          // =====================
          const Text(
            "HOST ACTIONS",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (!gameStarted)
                ElevatedButton.icon(
                  onPressed: onStart,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Game"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
              if (gameStarted) ...[
                ElevatedButton.icon(
                  onPressed: onNextNumber,
                  icon: const Icon(Icons.skip_next),
                  label: const Text("Next Number"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: gamePaused ? onResume : onPause,
                  icon: Icon(gamePaused ? Icons.play_arrow : Icons.pause),
                  label: Text(gamePaused ? "Resume" : "Pause"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gamePaused ? Colors.green : Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
              OutlinedButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.refresh, color: Colors.redAccent),
                label: const Text("Reset Heat", style: TextStyle(color: Colors.redAccent)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white60, fontSize: 11),
              ),
              Text(
                value,
                style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
