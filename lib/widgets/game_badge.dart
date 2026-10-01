import 'package:flutter/material.dart';

class GameBadge extends StatelessWidget {
  final String label;

  final IconData? icon;

  final Color color;

  final bool outlined;

  final double fontSize;

  const GameBadge({
    super.key,
    required this.label,
    this.icon,
    this.color = Colors.indigo,
    this.outlined = false,
    this.fontSize = 11,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: outlined
            ? Colors.transparent
            : color.withOpacity(
                0.12,
              ),
        borderRadius: BorderRadius.circular(
          14,
        ),
        border: Border.all(
          color: color.withOpacity(
            0.28,
          ),
          width: 1.3,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: color,
              size: 16,
            ),
            const SizedBox(
              width: 6,
            ),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
