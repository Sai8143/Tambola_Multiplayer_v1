import 'package:flutter/material.dart';

class GameStatusBanner extends StatelessWidget {
  final bool started;

  final bool paused;

  final bool finished;

  final int round;

  const GameStatusBanner({
    super.key,
    required this.started,
    required this.paused,
    required this.finished,
    required this.round,
  });

  // =========================
  // TITLE
  // =========================

  String get title {
    if (finished) {
      return "Game Finished";
    }

    if (!started) {
      return "Waiting For Match";
    }

    if (paused) {
      return "Game Paused";
    }

    return "Match Running";
  }

  // =========================
  // SUBTITLE
  // =========================

  String get subtitle {
    if (finished) {
      return "The match has ended successfully.";
    }

    if (!started) {
      return "Admin must start the game.";
    }

    if (paused) {
      return "Gameplay temporarily suspended.";
    }

    return "Round $round currently active.";
  }

  // =========================
  // COLORS
  // =========================

  List<Color> get colors {
    if (finished) {
      return [
        Colors.green,
        Colors.teal,
      ];
    }

    if (!started) {
      return [
        Colors.grey,
        Colors.blueGrey,
      ];
    }

    if (paused) {
      return [
        Colors.orange,
        Colors.deepOrange,
      ];
    }

    return [
      Colors.deepPurple,
      Colors.indigo,
    ];
  }

  // =========================
  // ICON
  // =========================

  IconData get icon {
    if (finished) {
      return Icons.emoji_events;
    }

    if (!started) {
      return Icons.hourglass_empty;
    }

    if (paused) {
      return Icons.pause_circle;
    }

    return Icons.play_circle;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 22,
      ),
      padding: const EdgeInsets.all(
        24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================
          // ICON
          // =====================

          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.14,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          // =====================
          // CONTENT
          // =====================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade100,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.14,
                    ),
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Text(
                    finished
                        ? "COMPLETED"
                        : paused
                            ? "PAUSED"
                            : started
                                ? "LIVE"
                                : "WAITING",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 11,
                    ),
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
