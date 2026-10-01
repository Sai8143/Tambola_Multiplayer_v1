import 'package:flutter/material.dart';

class GameRoundTracker extends StatelessWidget {
  final int currentRound;

  final int currentTurn;

  final int maxRounds;

  final int numbersGenerated;

  const GameRoundTracker({
    super.key,
    required this.currentRound,
    required this.currentTurn,
    required this.maxRounds,
    required this.numbersGenerated,
  });

  // =========================
  // ROUND PROGRESS
  // =========================

  double get roundProgress {
    if (maxRounds == 0) {
      return 0;
    }

    return currentRound / maxRounds;
  }

  // =========================
  // TURN PROGRESS
  // =========================

  double get turnProgress {
    return (currentTurn / 10).clamp(0, 1);
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
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
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
              0.24,
            ),
            blurRadius: 18,
            offset: const Offset(
              0,
              10,
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
                  color: Colors.white.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.autorenew,
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
                      "Round Tracker",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Live match progression",
                      style: TextStyle(
                        color: Colors.white70,
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
                  color: Colors.white.withOpacity(
                    0.10,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "ROUND $currentRound",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 30,
          ),

          // =====================
          // ROUND STATUS
          // =====================

          buildProgressCard(
            title: "Round Progress",
            icon: Icons.flag,
            value: "$currentRound / $maxRounds",
            progress: roundProgress,
            progressColor: Colors.greenAccent,
          ),

          const SizedBox(
            height: 24,
          ),

          // =====================
          // TURN STATUS
          // =====================

          buildProgressCard(
            title: "Turn Progress",
            icon: Icons.timelapse,
            value: "$currentTurn / 10",
            progress: turnProgress,
            progressColor: Colors.orangeAccent,
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // GENERATED NUMBERS
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.06,
              ),
              borderRadius: BorderRadius.circular(
                24,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.indigo,
                        Colors.deepPurple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: const Icon(
                    Icons.pin,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Generated Numbers",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "$numbersGenerated numbers have been generated during the match.",
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  numbersGenerated.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // PROGRESS CARD
  // =========================

  Widget buildProgressCard({
    required String title,
    required IconData icon,
    required String value,
    required double progress,
    required Color progressColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          0.06,
        ),
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              12,
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(
                progressColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
