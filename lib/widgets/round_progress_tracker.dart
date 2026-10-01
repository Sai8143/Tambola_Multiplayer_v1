import 'package:flutter/material.dart';

class RoundProgressTracker extends StatelessWidget {
  final int calledNumbers;

  final int currentRound;

  final int totalRounds;

  const RoundProgressTracker({
    super.key,
    required this.calledNumbers,
    required this.currentRound,
    this.totalRounds = 9,
  });

  // =========================
  // ROUND PROGRESS
  // =========================

  double get progress {
    return calledNumbers / 90;
  }

  // =========================
  // CURRENT ROUND START
  // =========================

  int get currentRoundStart {
    return ((currentRound - 1) * 10) + 1;
  }

  // =========================
  // CURRENT ROUND END
  // =========================

  int get currentRoundEnd {
    return currentRound * 10;
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
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.22,
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
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.timeline,
                  color: Colors.white,
                  size: 32,
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
                      "Round Tracker",
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
                      "Track match progression",
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
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "R$currentRound",
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
          // CURRENT ROUND
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              20,
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
                Row(
                  children: [
                    const Icon(
                      Icons.autorenew,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        "Current Round",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "$currentRound / $totalRounds",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  child: LinearProgressIndicator(
                    value: currentRound / totalRounds,
                    minHeight: 12,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Numbers $currentRoundStart - $currentRoundEnd",
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${(currentRound / totalRounds * 100).toInt()}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // ROUND GRID
          // =====================

          GridView.builder(
            itemCount: totalRounds,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (
              context,
              index,
            ) {
              final round = index + 1;

              final bool active = round == currentRound;

              final bool completed = round < currentRound;

              return AnimatedContainer(
                duration: const Duration(
                  milliseconds: 250,
                ),
                decoration: BoxDecoration(
                  gradient: active
                      ? const LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.indigo,
                          ],
                        )
                      : completed
                          ? const LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.teal,
                              ],
                            )
                          : LinearGradient(
                              colors: [
                                Colors.white.withOpacity(
                                  0.08,
                                ),
                                Colors.white.withOpacity(
                                  0.04,
                                ),
                              ],
                            ),
                  borderRadius: BorderRadius.circular(
                    22,
                  ),
                  border: Border.all(
                    color: active ? Colors.white : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      completed
                          ? Icons.check
                          : active
                              ? Icons.autorenew
                              : Icons.radio_button_unchecked,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Round $round",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${((round - 1) * 10) + 1}-${round * 10}",
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(
            height: 26,
          ),

          // =====================
          // MATCH PROGRESS
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
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.speed,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        "Overall Match Progress",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "$calledNumbers / 90",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 14,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(
                      Colors.greenAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${(progress * 100).toInt()}% Complete",
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontWeight: FontWeight.w600,
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
