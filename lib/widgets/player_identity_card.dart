import 'package:flutter/material.dart';

class PlayerIdentityCard extends StatelessWidget {
  final String playerName;

  final String playerId;

  final bool online;

  final bool influencer;

  final bool eliminated;

  final int score;

  const PlayerIdentityCard({
    super.key,
    required this.playerName,
    required this.playerId,
    required this.online,
    required this.influencer,
    required this.eliminated,
    required this.score,
  });

  // =========================
  // STATUS TEXT
  // =========================

  String get statusText {
    if (eliminated) {
      return "ELIMINATED";
    }

    if (online) {
      return "ONLINE";
    }

    return "OFFLINE";
  }

  // =========================
  // STATUS COLOR
  // =========================

  Color get statusColor {
    if (eliminated) {
      return Colors.red;
    }

    if (online) {
      return Colors.green;
    }

    return Colors.grey;
  }

  // =========================
  // ROLE COLOR
  // =========================

  List<Color> get roleColors {
    if (influencer) {
      return [
        Colors.red,
        Colors.deepPurple,
      ];
    }

    return [
      Colors.indigo,
      Colors.blue,
    ];
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
        gradient: LinearGradient(
          colors: roleColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: roleColors.first.withOpacity(
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
      child: Row(
        children: [
          // =====================
          // AVATAR
          // =====================

          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.14,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                playerName
                    .substring(
                      0,
                      1,
                    )
                    .toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          // =====================
          // DETAILS
          // =====================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "ID: $playerId",
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(
                          0.16,
                        ),
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor == Colors.green
                              ? Colors.greenAccent
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.12,
                        ),
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: Text(
                        influencer ? "INFLUENCER" : "PLAYER",
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
              ],
            ),
          ),

          // =====================
          // SCORE
          // =====================

          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.12,
              ),
              borderRadius: BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.stars,
                  color: Colors.amber,
                  size: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  score.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "SCORE",
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
