import 'package:flutter/material.dart';

import '../models/influence_action.dart';

class InfluencePanel extends StatefulWidget {
  final int energy;

  final bool enabled;

  final Function(
    InfluenceActionType action,
  ) onAction;

  const InfluencePanel({
    super.key,
    required this.energy,
    required this.onAction,
    this.enabled = true,
  });

  @override
  State<InfluencePanel> createState() => _InfluencePanelState();
}

class _InfluencePanelState extends State<InfluencePanel>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> glowAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    glowAnimation = Tween<double>(
      begin: 0.96,
      end: 1.02,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.repeat(
      reverse: true,
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  // =========================
  // ENERGY COLOR
  // =========================

  Color get energyColor {
    if (widget.energy >= 70) {
      return Colors.greenAccent;
    }

    if (widget.energy >= 40) {
      return Colors.orangeAccent;
    }

    return Colors.redAccent;
  }

  // =========================
  // ENERGY STATUS
  // =========================

  String get energyStatus {
    if (widget.energy >= 70) {
      return "HIGH";
    }

    if (widget.energy >= 40) {
      return "MEDIUM";
    }

    return "LOW";
  }

  // =========================
  // ACTION ICON
  // =========================

  IconData getActionIcon(
    InfluenceActionType action,
  ) {
    final name = action.toString().split('.').last.toLowerCase();

    if (name.contains('peek')) {
      return Icons.visibility;
    }

    if (name.contains('swap')) {
      return Icons.swap_horiz;
    }

    if (name.contains('shuffle')) {
      return Icons.shuffle;
    }

    if (name.contains('freeze')) {
      return Icons.ac_unit;
    }

    if (name.contains('hack')) {
      return Icons.bolt;
    }

    return Icons.flash_on;
  }

  String getActionTitle(
    InfluenceActionType action,
  ) {
    final raw = action.toString().split('.').last;

    return raw.replaceAll('_', ' ').toUpperCase();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ScaleTransition(
      scale: glowAnimation,
      child: Container(
        margin: const EdgeInsets.only(
          top: 24,
        ),
        padding: const EdgeInsets.all(
          24,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(
                0xFF7C3AED,
              ),
              Color(
                0xFFDC2626,
              ),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            32,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(
                0.22,
              ),
              blurRadius: 22,
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
                  width: 68,
                  height: 68,
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
                  width: 18,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Influence Panel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Control hidden influence abilities",
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.12,
                    ),
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Text(
                    energyStatus,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
            // ENERGY CARD
            // =====================

            Container(
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
                        Icons.flash_on,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          "Influence Energy",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.energy}%",
                        style: TextStyle(
                          color: energyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    child: LinearProgressIndicator(
                      value: widget.energy / 100,
                      minHeight: 14,
                      backgroundColor: Colors.white12,
                      valueColor: AlwaysStoppedAnimation(
                        energyColor,
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
            // TITLE
            // =====================

            const Text(
              "INFLUENCE ACTIONS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            // =====================
            // ACTION BUTTONS
            // =====================

            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: InfluenceActionType.values.map(
                (
                  action,
                ) {
                  final disabled = widget.energy <= 0 || !widget.enabled;

                  return buildActionButton(
                    action: action,
                    disabled: disabled,
                  );
                },
              ).toList(),
            ),

            const SizedBox(
              height: 28,
            ),

            // =====================
            // WARNING
            // =====================

            Container(
              padding: const EdgeInsets.all(
                18,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.18,
                ),
                borderRadius: BorderRadius.circular(
                  22,
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(
                    0.08,
                  ),
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
                      "Excessive influence usage increases suspicion heat and may expose the influencer to all players.",
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        height: 1.6,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // ACTION BUTTON
  // =========================

  Widget buildActionButton({
    required InfluenceActionType action,
    required bool disabled,
  }) {
    return ElevatedButton(
      onPressed: disabled
          ? null
          : () {
              widget.onAction(
                action,
              );
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
        disabledBackgroundColor: Colors.white24,
        disabledForegroundColor: Colors.white54,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            getActionIcon(
              action,
            ),
            size: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            getActionTitle(
              action,
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
