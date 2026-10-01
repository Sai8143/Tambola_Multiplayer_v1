import 'package:flutter/material.dart';

class InfluencerWarningCard extends StatefulWidget {
  final bool visible;

  final int suspicionLevel;

  final String message;

  const InfluencerWarningCard({
    super.key,
    required this.visible,
    required this.suspicionLevel,
    required this.message,
  });

  @override
  State<InfluencerWarningCard> createState() => _InfluencerWarningCardState();
}

class _InfluencerWarningCardState extends State<InfluencerWarningCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> pulseAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    pulseAnimation = Tween<double>(
      begin: 0.96,
      end: 1.02,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.visible) {
      controller.repeat(
        reverse: true,
      );
    }
  }

  @override
  void didUpdateWidget(
    covariant InfluencerWarningCard oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (widget.visible && !oldWidget.visible) {
      controller.repeat(
        reverse: true,
      );
    }

    if (!widget.visible && oldWidget.visible) {
      controller.stop();

      controller.reset();
    }
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  // =========================
  // ALERT COLOR
  // =========================

  Color get alertColor {
    if (widget.suspicionLevel >= 80) {
      return Colors.red;
    }

    if (widget.suspicionLevel >= 50) {
      return Colors.orange;
    }

    return Colors.amber;
  }

  // =========================
  // ALERT STATUS
  // =========================

  String get status {
    if (widget.suspicionLevel >= 80) {
      return "CRITICAL";
    }

    if (widget.suspicionLevel >= 50) {
      return "WARNING";
    }

    return "CAUTION";
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    if (!widget.visible) {
      return const SizedBox();
    }

    return ScaleTransition(
      scale: pulseAnimation,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 22,
        ),
        padding: const EdgeInsets.all(
          24,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              alertColor,
              Colors.deepOrange,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          boxShadow: [
            BoxShadow(
              color: alertColor.withOpacity(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================
            // ALERT ICON
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
                Icons.warning_amber,
                color: Colors.white,
                size: 42,
              ),
            ),

            const SizedBox(
              width: 18,
            ),

            // ===================
            // CONTENT
            // ===================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===============
                  // STATUS CHIP
                  // ===============

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
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // ===============
                  // TITLE
                  // ===============

                  const Text(
                    "Suspicion Rising",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // ===============
                  // MESSAGE
                  // ===============

                  Text(
                    widget.message,
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // ===============
                  // PROGRESS
                  // ===============

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          child: LinearProgressIndicator(
                            value: widget.suspicionLevel / 100,
                            minHeight: 12,
                            backgroundColor: Colors.white12,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "${widget.suspicionLevel}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
