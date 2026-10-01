import 'package:flutter/material.dart';

class GameDividerTitle extends StatelessWidget {
  final String title;

  final Color color;

  const GameDividerTitle({
    super.key,
    required this.title,
    this.color = Colors.indigo,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        // =====================
        // LEFT LINE
        // =====================

        Expanded(
          child: Container(
            height: 1.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(
                    0,
                  ),
                  color.withOpacity(
                    0.5,
                  ),
                ],
              ),
            ),
          ),
        ),

        // =====================
        // TITLE
        // =====================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.4,
            ),
          ),
        ),

        // =====================
        // RIGHT LINE
        // =====================

        Expanded(
          child: Container(
            height: 1.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(
                    0.5,
                  ),
                  color.withOpacity(
                    0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
