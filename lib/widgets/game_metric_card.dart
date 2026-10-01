import 'package:flutter/material.dart';

class GameMetricCard extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  final Color color;

  final String? subtitle;

  const GameMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(
              0.72,
            ),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          28,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(
              0.20,
            ),
            blurRadius: 14,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================
          // TOP ROW
          // ===================

          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.14,
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
              const Spacer(),
              Icon(
                Icons.trending_up,
                color: Colors.white.withOpacity(
                  0.7,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          // ===================
          // VALUE
          // ===================

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          // ===================
          // TITLE
          // ===================

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade100,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),

          // ===================
          // SUBTITLE
          // ===================

          if (subtitle != null) ...[
            const SizedBox(
              height: 10,
            ),
            Text(
              subtitle!,
              style: TextStyle(
                color: Colors.grey.shade200,
                height: 1.5,
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
