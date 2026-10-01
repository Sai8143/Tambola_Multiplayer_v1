import 'package:flutter/material.dart';

class GamePlayerTile extends StatelessWidget {
  final String name;

  final int score;

  final bool influencer;

  final bool online;

  final bool eliminated;

  final VoidCallback? onTap;

  const GamePlayerTile({
    super.key,
    required this.name,
    required this.score,
    this.influencer = false,
    this.online = true,
    this.eliminated = false,
    this.onTap,
  });

  // =========================
  // COLORS
  // =========================

  List<Color> get colors {
    if (eliminated) {
      return [
        Colors.red,
        Colors.deepOrange,
      ];
    }

    if (influencer) {
      return [
        Colors.deepPurple,
        Colors.red,
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          28,
        ),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(
            18,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              28,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.05,
                ),
                blurRadius: 12,
                offset: const Offset(
                  0,
                  6,
                ),
              ),
            ],
          ),
          child: Row(
            children: [
              // =================
              // AVATAR
              // =================

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        name
                            .substring(
                              0,
                              1,
                            )
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (!eliminated)
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: online ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(
                width: 18,
              ),

              // =================
              // PLAYER INFO
              // =================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
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
                          color: influencer ? Colors.deepPurple : Colors.indigo,
                        ),
                        if (eliminated)
                          buildChip(
                            label: "ELIMINATED",
                            color: Colors.red,
                          ),
                        buildChip(
                          label: online ? "ONLINE" : "OFFLINE",
                          color: online ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              // =================
              // SCORE
              // =================

              Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: colors.first.withOpacity(
                        0.12,
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        score.toString(),
                        style: TextStyle(
                          color: colors.first,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Score",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
