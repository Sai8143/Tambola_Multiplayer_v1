import 'package:flutter/material.dart';

class GameResultDialog extends StatelessWidget {
  final bool playersWon;

  final String title;

  final String description;

  final VoidCallback onRestart;

  final VoidCallback onExit;

  const GameResultDialog({
    super.key,
    required this.playersWon,
    required this.title,
    required this.description,
    required this.onRestart,
    required this.onExit,
  });

  // =========================
  // COLORS
  // =========================

  List<Color> get colors {
    if (playersWon) {
      return [
        Colors.green,
        Colors.teal,
      ];
    }

    return [
      Colors.red,
      Colors.deepPurple,
    ];
  }

  // =========================
  // ICON
  // =========================

  IconData get resultIcon {
    return playersWon ? Icons.emoji_events : Icons.visibility;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(
        24,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          28,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            36,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(
                0.28,
              ),
              blurRadius: 22,
              offset: const Offset(
                0,
                12,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ===================
            // ICON
            // ===================

            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.14,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                resultIcon,
                color: Colors.white,
                size: 76,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // ===================
            // TITLE
            // ===================

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            // ===================
            // DESCRIPTION
            // ===================

            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade100,
                fontSize: 16,
                height: 1.7,
              ),
            ),

            const SizedBox(
              height: 34,
            ),

            // ===================
            // BUTTONS
            // ===================

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: colors.first,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    child: const Text(
                      "Restart",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onExit,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    child: const Text(
                      "Exit",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
