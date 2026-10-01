import 'package:flutter/material.dart';

class GameStatusChip extends StatelessWidget {
  final String label;

  final IconData icon;

  final Color color;

  final bool outlined;

  const GameStatusChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.outlined = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: outlined
            ? Colors.transparent
            : color.withOpacity(
                0.12,
              ),
        borderRadius: BorderRadius.circular(
          18,
        ),
        border: Border.all(
          color: color.withOpacity(
            0.30,
          ),
          width: 1.4,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
