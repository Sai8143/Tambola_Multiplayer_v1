import 'package:flutter/material.dart';

class ChaosMeter extends StatelessWidget {
  final int heat;

  const ChaosMeter({
    super.key,
    required this.heat,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (heat / 100).clamp(0.0, 1.0);
    final bool low = heat < 40;
    final bool medium = heat >= 40 && heat < 75;
    final bool critical = heat >= 75;

    final Color color = low
        ? Colors.greenAccent
        : medium
            ? Colors.orangeAccent
            : Colors.redAccent;

    final String level = low
        ? "LOW"
        : medium
            ? "MEDIUM"
            : "CRITICAL";

    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department, color: color, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Chaos & Heat Meter",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      critical
                          ? "Glitches & distortions occurring!"
                          : medium
                              ? "Suspicious influence in progress."
                              : "Room atmosphere stable.",
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$level ($heat%)",
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}
