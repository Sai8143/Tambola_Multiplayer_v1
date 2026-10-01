import 'package:flutter/material.dart';

class PlayerMatchInsights extends StatelessWidget {
  final int suspicionLevel;

  final int totalPredictions;

  final int successfulPredictions;

  final int markedNumbers;

  final int rank;

  const PlayerMatchInsights({
    super.key,
    required this.suspicionLevel,
    required this.totalPredictions,
    required this.successfulPredictions,
    required this.markedNumbers,
    required this.rank,
  });

  // =========================
  // ACCURACY
  // =========================

  double get accuracy {
    if (totalPredictions == 0) {
      return 0;
    }

    return successfulPredictions / totalPredictions;
  }

  // =========================
  // RISK STATUS
  // =========================

  String get riskStatus {
    if (suspicionLevel >= 80) {
      return "CRITICAL";
    }

    if (suspicionLevel >= 50) {
      return "WARNING";
    }

    return "SAFE";
  }

  // =========================
  // RISK COLOR
  // =========================

  Color get riskColor {
    if (suspicionLevel >= 80) {
      return Colors.red;
    }

    if (suspicionLevel >= 50) {
      return Colors.orange;
    }

    return Colors.green;
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
            Color(0xFF111827),
            Color(0xFF1F2937),
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
              0.22,
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
                  Icons.insights,
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
                      "Match Insights",
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
                      "Performance analytics",
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
                  color: riskColor.withOpacity(
                    0.14,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  riskStatus,
                  style: TextStyle(
                    color: riskColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // STATS GRID
          // =====================

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.35,
            children: [
              buildStatCard(
                title: "Marked",
                value: markedNumbers.toString(),
                icon: Icons.check_circle,
                color: Colors.green,
              ),
              buildStatCard(
                title: "Predictions",
                value: totalPredictions.toString(),
                icon: Icons.psychology,
                color: Colors.deepPurple,
              ),
              buildStatCard(
                title: "Successful",
                value: successfulPredictions.toString(),
                icon: Icons.workspace_premium,
                color: Colors.orange,
              ),
              buildStatCard(
                title: "Rank",
                value: "#$rank",
                icon: Icons.leaderboard,
                color: Colors.blue,
              ),
            ],
          ),

          const SizedBox(
            height: 30,
          ),

          // =====================
          // ACCURACY
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
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        "Prediction Accuracy",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${(accuracy * 100).toInt()}%",
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
                    value: accuracy,
                    minHeight: 14,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(
                      Colors.greenAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // SUSPICION LEVEL
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: riskColor.withOpacity(
                0.08,
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
                      Icons.warning,
                      color: riskColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        "Suspicion Level",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "$suspicionLevel%",
                      style: TextStyle(
                        color: riskColor,
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
                    value: suspicionLevel / 100,
                    minHeight: 14,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(
                      riskColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  suspicionLevel >= 80
                      ? "Players are highly suspicious of your actions."
                      : suspicionLevel >= 50
                          ? "Your predictions are drawing attention."
                          : "Your activity currently appears normal.",
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    height: 1.5,
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
        color: Colors.white.withOpacity(
          0.06,
        ),
        borderRadius: BorderRadius.circular(
          22,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
