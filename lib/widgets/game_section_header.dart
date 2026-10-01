import 'package:flutter/material.dart';

class GameSectionHeader extends StatelessWidget {
  final String title;

  final String subtitle;

  final IconData icon;

  final Color color;

  final Widget? action;

  const GameSectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color = Colors.indigo,
    this.action,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================
        // ICON
        // =====================

        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(
                  0.72,
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(
              18,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),

        const SizedBox(
          width: 16,
        ),

        // =====================
        // TITLES
        // =====================

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        // =====================
        // ACTION
        // =====================

        if (action != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: action!,
          ),
      ],
    );
  }
}
