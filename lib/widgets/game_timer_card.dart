import 'package:flutter/material.dart';

class GameTimerCard extends StatelessWidget {
  final Duration remainingTime;

  final bool warning;

  const GameTimerCard({
    super.key,
    required this.remainingTime,
    this.warning = false,
  });

  // =========================
  // FORMAT TIME
  // =========================

  String formatTime(
    Duration duration,
  ) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final color = warning ? Colors.red : Colors.indigo;

    return Container(
      padding: const EdgeInsets.all(
        22,
      ),
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
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(
              0.22,
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
        children: [
          // ===================
          // ICON
          // ===================

          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.14,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.timer,
              color: Colors.white,
              size: 38,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // ===================
          // TIME
          // ===================

          Text(
            formatTime(
              remainingTime,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // ===================
          // LABEL
          // ===================

          Text(
            warning ? "TIME RUNNING OUT" : "ROUND TIMER",
            style: TextStyle(
              color: Colors.grey.shade100,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
