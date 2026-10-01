import 'package:flutter/material.dart';

class InfluencerPredictionPanel extends StatelessWidget {
  final List<int> upcomingNumbers;

  final bool enabled;

  final Function(int number) onPredict;

  const InfluencerPredictionPanel({
    super.key,
    required this.upcomingNumbers,
    required this.enabled,
    required this.onPredict,
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
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3B0764),
            Color(0xFF581C87),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(
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
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.10,
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.visibility,
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
                      "Secret Predictions",
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
                      "Upcoming hidden numbers",
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
                  color: enabled
                      ? Colors.green.withOpacity(
                          0.14,
                        )
                      : Colors.orange.withOpacity(
                          0.14,
                        ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  enabled ? "ACTIVE" : "LOCKED",
                  style: TextStyle(
                    color: enabled ? Colors.greenAccent : Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // WARNING BOX
          // =====================

          Container(
            width: double.infinity,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Using future numbers carelessly may expose your identity to other players.",
                    style: TextStyle(
                      color: Colors.grey.shade300,
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
          // NUMBER GRID
          // =====================

          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: upcomingNumbers.map(
              (
                number,
              ) {
                return GestureDetector(
                  onTap: enabled
                      ? () {
                          onPredict(
                            number,
                          );
                        }
                      : null,
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 220,
                    ),
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.deepPurple,
                          Colors.indigo,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        24,
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(
                          0.14,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(
                            0.18,
                          ),
                          blurRadius: 10,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        number.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),

          const SizedBox(
            height: 30,
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
                  Icons.lock,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Prediction access is restricted to the influencer role only.",
                    style: TextStyle(
                      color: Colors.grey.shade300,
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
