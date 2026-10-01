import 'package:flutter/material.dart';

class GameInfoTile extends StatelessWidget {
  final String title;

  final String subtitle;

  final IconData icon;

  final Color color;

  final VoidCallback? onTap;

  const GameInfoTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          24,
        ),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(
            18,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(
              0.08,
            ),
            borderRadius: BorderRadius.circular(
              24,
            ),
            border: Border.all(
              color: color.withOpacity(
                0.16,
              ),
            ),
          ),
          child: Row(
            children: [
              // ===================
              // ICON
              // ===================

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
                  size: 28,
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              // ===================
              // CONTENT
              // ===================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
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

              // ===================
              // ARROW
              // ===================

              Icon(
                Icons.chevron_right,
                color: color.withOpacity(
                  0.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
