import 'package:flutter/material.dart';

class GameNumberChip extends StatelessWidget {
  final int number;

  final bool selected;

  final bool highlighted;

  final VoidCallback? onTap;

  const GameNumberChip({
    super.key,
    required this.number,
    this.selected = false,
    this.highlighted = false,
    this.onTap,
  });

  // =========================
  // COLORS
  // =========================

  List<Color> get colors {
    if (highlighted) {
      return [
        Colors.orange,
        Colors.deepOrange,
      ];
    }

    if (selected) {
      return [
        Colors.green,
        Colors.teal,
      ];
    }

    return [
      Colors.grey.shade100,
      Colors.grey.shade200,
    ];
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final bool active = selected || highlighted;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 220,
        ),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(
            22,
          ),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: colors.first.withOpacity(
                      0.24,
                    ),
                    blurRadius: 12,
                    offset: const Offset(
                      0,
                      6,
                    ),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: active ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
