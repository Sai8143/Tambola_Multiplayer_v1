import 'package:flutter/material.dart';

class LiveCalledNumbers extends StatelessWidget {
  final List<int> calledNumbers;

  final int? latestNumber;

  const LiveCalledNumbers({
    super.key,
    required this.calledNumbers,
    required this.latestNumber,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        top: 22,
      ),
      padding: const EdgeInsets.all(
        22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.06,
            ),
            blurRadius: 14,
            offset: const Offset(
              0,
              6,
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
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.teal,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.history_toggle_off,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Called Numbers",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Live generated numbers",
                      style: TextStyle(
                        color: Colors.grey,
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
                  color: Colors.green.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "${calledNumbers.length}",
                  style: const TextStyle(
                    color: Colors.green,
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
          // EMPTY
          // =====================

          if (calledNumbers.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 36,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.casino,
                    size: 44,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "No numbers generated yet",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          // =====================
          // GRID
          // =====================

          if (calledNumbers.isNotEmpty)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: calledNumbers.reversed.map(
                (
                  number,
                ) {
                  final bool latest = latestNumber == number;

                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      gradient: latest
                          ? const LinearGradient(
                              colors: [
                                Colors.deepPurple,
                                Colors.indigo,
                              ],
                            )
                          : const LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.teal,
                              ],
                            ),
                      borderRadius: BorderRadius.circular(
                        22,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: latest
                              ? Colors.deepPurple.withOpacity(
                                  0.22,
                                )
                              : Colors.green.withOpacity(
                                  0.16,
                                ),
                          blurRadius: 10,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            number.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (latest)
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  0.18,
                                ),
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                              ),
                              child: const Text(
                                "NEW",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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
            width: double.infinity,
            padding: const EdgeInsets.all(
              18,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                22,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info,
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Every 10 numbers automatically triggers the next round.",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      height: 1.5,
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
}
