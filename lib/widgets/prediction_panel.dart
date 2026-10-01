import 'package:flutter/material.dart';

class PredictionPanel extends StatefulWidget {
  final Function(String) onPredict;

  final bool enabled;

  final List<String> suggestions;

  const PredictionPanel({
    super.key,
    required this.onPredict,
    this.enabled = true,
    this.suggestions = const [
      "even",
      "odd",
      "high",
      "low",
    ],
  });

  @override
  State<PredictionPanel> createState() => _PredictionPanelState();
}

class _PredictionPanelState extends State<PredictionPanel> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  // =========================
  // SUBMIT PREDICTION
  // =========================

  void submitPrediction(
    String value,
  ) {
    if (!widget.enabled) {
      return;
    }

    if (value.trim().isEmpty) {
      return;
    }

    widget.onPredict(
      value.trim(),
    );

    controller.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          "Prediction Submitted: $value",
        ),
      ),
    );
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
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.deepPurple,
                      Colors.indigo,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.psychology,
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
                      "Prediction System",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Predict future outcomes",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? Colors.green.withOpacity(
                          0.12,
                        )
                      : Colors.red.withOpacity(
                          0.12,
                        ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  widget.enabled ? "ACTIVE" : "LOCKED",
                  style: TextStyle(
                    color: widget.enabled ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          // =====================
          // INFO BOX
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              18,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(
                    0.08,
                  ),
                  Colors.indigo.withOpacity(
                    0.04,
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(
                22,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.tips_and_updates,
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Make strategic predictions during rounds. Correct predictions increase trust and intelligence.",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          // =====================
          // INPUT
          // =====================

          TextField(
            controller: controller,
            enabled: widget.enabled,
            decoration: InputDecoration(
              hintText: "Type your prediction...",
              prefixIcon: const Icon(
                Icons.edit,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // =====================
          // QUICK PREDICTIONS
          // =====================

          const Text(
            "Quick Predictions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.suggestions.map(
              (
                item,
              ) {
                return ActionChip(
                  label: Text(
                    item,
                  ),
                  avatar: const Icon(
                    Icons.auto_awesome,
                    size: 18,
                  ),
                  backgroundColor: Colors.deepPurple.withOpacity(
                    0.08,
                  ),
                  side: BorderSide(
                    color: Colors.deepPurple.withOpacity(
                      0.14,
                    ),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: widget.enabled
                      ? () {
                          submitPrediction(
                            item,
                          );
                        }
                      : null,
                );
              },
            ).toList(),
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // SUBMIT BUTTON
          // =====================

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.enabled
                  ? () {
                      submitPrediction(
                        controller.text,
                      );
                    }
                  : null,
              icon: const Icon(
                Icons.send,
              ),
              label: Text(
                widget.enabled ? "Submit Prediction" : "Prediction Locked",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade400,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
