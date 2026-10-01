import 'package:flutter/material.dart';

class UpcomingNumbersPanel extends StatelessWidget {
  final List<int> upcomingNumbers;

  final bool visible;

  final bool isInfluencer;

  const UpcomingNumbersPanel({
    super.key,
    required this.upcomingNumbers,
    required this.visible,
    required this.isInfluencer,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    // =========================
    // ONLY INFLUENCER
    // =========================

    if (!visible || !isInfluencer) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(
        top: 22,
      ),
      padding: const EdgeInsets.all(
        24,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.red,
            Colors.deepPurple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(
              0.24,
            ),
            blurRadius: 18,
            offset: const Offset(
              0,
              10,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================
          // HEADER
          // =====================

          Row(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.14,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.visibility,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hidden Predictions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Exclusive influencer vision",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.14,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "${upcomingNumbers.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // WARNING
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              18,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(
                0.16,
              ),
              borderRadius: BorderRadius.circular(
                22,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.amber,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "These numbers are visible only to influencers. Use this advantage carefully to avoid suspicion.",
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // NUMBERS GRID
          // =====================

          if (upcomingNumbers.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 34,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.08,
                ),
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.visibility_off,
                    size: 44,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "No upcoming numbers available",
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          if (upcomingNumbers.isNotEmpty)
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: upcomingNumbers.asMap().entries.map(
                (
                  entry,
                ) {
                  final index = entry.key;

                  final value = entry.value;

                  return buildNumberCard(
                    number: value,
                    index: index,
                  );
                },
              ).toList(),
            ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // FOOTER
          // =====================

          Container(
            padding: const EdgeInsets.all(
              18,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.08,
              ),
              borderRadius: BorderRadius.circular(
                22,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.psychology,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Influence prediction engine synchronized.",
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // NUMBER CARD
  // =========================

  Widget buildNumberCard({
    required int number,
    required int index,
  }) {
    return Container(
      width: 86,
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.white,
            Color(0xFFF5F3FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          24,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.08,
            ),
            blurRadius: 10,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(
                0.08,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Text(
              "NEXT ${index + 1}",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
