import 'package:flutter/material.dart';

class HistoryStrip extends StatelessWidget {
  final List<int> history;

  final int? highlightedNumber;

  const HistoryStrip({
    super.key,
    required this.history,
    this.highlightedNumber,
  });

  // =========================
  // LAST 15 NUMBERS
  // =========================

  List<int> get visibleHistory {
    if (history.length <= 15) {
      return history.reversed.toList();
    }

    return history
        .sublist(
          history.length - 15,
        )
        .reversed
        .toList();
  }

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
          28,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.06,
            ),
            blurRadius: 12,
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
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.deepPurple,
                      Colors.indigo,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: const Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 28,
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
                      "Recent fate history",
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
                  color: Colors.deepPurple.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "${history.length}/90",
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          // =====================
          // EMPTY
          // =====================

          if (history.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 34,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  22,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.confirmation_number_outlined,
                    size: 42,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "No numbers called yet",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          // =====================
          // HISTORY NUMBERS
          // =====================

          if (history.isNotEmpty)
            SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: visibleHistory.length,
                separatorBuilder: (
                  _,
                  __,
                ) =>
                    const SizedBox(
                  width: 14,
                ),
                itemBuilder: (
                  context,
                  index,
                ) {
                  final number = visibleHistory[index];

                  final bool isLatest = index == 0;

                  final bool highlighted = highlightedNumber == number;

                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    width: isLatest ? 78 : 68,
                    decoration: BoxDecoration(
                      gradient: highlighted
                          ? const LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.red,
                              ],
                            )
                          : isLatest
                              ? const LinearGradient(
                                  colors: [
                                    Colors.deepPurple,
                                    Colors.indigo,
                                  ],
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.grey.shade200,
                                    Colors.grey.shade100,
                                  ],
                                ),
                      borderRadius: BorderRadius.circular(
                        22,
                      ),
                      boxShadow: [
                        if (isLatest)
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(
                              0.24,
                            ),
                            blurRadius: 12,
                            offset: const Offset(
                              0,
                              5,
                            ),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLatest)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.16,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: const Text(
                              "LATEST",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        if (isLatest)
                          const SizedBox(
                            height: 10,
                          ),
                        Text(
                          number.toString(),
                          style: TextStyle(
                            color: isLatest || highlighted
                                ? Colors.white
                                : Colors.black87,
                            fontSize: isLatest ? 28 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
