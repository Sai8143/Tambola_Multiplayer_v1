import 'package:flutter/material.dart';

class PlayerStatisticsOverview extends StatelessWidget {
  final int gamesPlayed;

  final int gamesWon;

  final int totalPredictions;

  final int successfulPredictions;

  final int highestScore;

  final int totalMarkedNumbers;

  const PlayerStatisticsOverview({
    super.key,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.totalPredictions,
    required this.successfulPredictions,
    required this.highestScore,
    required this.totalMarkedNumbers,
  });

  // =========================
  // WIN RATE
  // =========================

  double get winRate {
    if (gamesPlayed == 0) {
      return 0;
    }

    return gamesWon / gamesPlayed;
  }

  // =========================
  // ACCURACY
  // =========================

  double get predictionAccuracy {
    if (totalPredictions == 0) {
      return 0;
    }

    return successfulPredictions / totalPredictions;
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
            Color(0xFF0F172A),
            Color(0xFF1E293B),
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
                  Icons.bar_chart,
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
                      "Player Statistics",
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
                      "Overall gameplay analytics",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 30,
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
                title: "Games",
                value: gamesPlayed.toString(),
                icon: Icons.sports_esports,
                color: Colors.blue,
              ),
              buildStatCard(
                title: "Wins",
                value: gamesWon.toString(),
                icon: Icons.emoji_events,
                color: Colors.green,
              ),
              buildStatCard(
                title: "Best Score",
                value: highestScore.toString(),
                icon: Icons.stars,
                color: Colors.orange,
              ),
              buildStatCard(
                title: "Marked",
                value: totalMarkedNumbers.toString(),
                icon: Icons.check_circle,
                color: Colors.teal,
              ),
            ],
          ),

          const SizedBox(
            height: 30,
          ),

          // =====================
          // WIN RATE
          // =====================

          buildProgressSection(
            title: "Win Rate",
            icon: Icons.workspace_premium,
            progress: winRate,
            percentage: "${(winRate * 100).toInt()}%",
            progressColor: Colors.greenAccent,
          ),

          const SizedBox(
            height: 24,
          ),

          // =====================
          // PREDICTION ACCURACY
          // =====================

          buildProgressSection(
            title: "Prediction Accuracy",
            icon: Icons.psychology,
            progress: predictionAccuracy,
            percentage: "${(predictionAccuracy * 100).toInt()}%",
            progressColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  // =========================
  // PROGRESS SECTION
  // =========================

  Widget buildProgressSection({
    required String title,
    required IconData icon,
    required double progress,
    required String percentage,
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
                percentage,
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
