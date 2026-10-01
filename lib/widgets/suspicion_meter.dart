import 'package:flutter/material.dart';

class SuspicionMeter extends StatefulWidget {
  final int suspicion;

  final bool animated;

  const SuspicionMeter({
    super.key,
    required this.suspicion,
    this.animated = true,
  });

  @override
  State<SuspicionMeter> createState() => _SuspicionMeterState();
}

class _SuspicionMeterState extends State<SuspicionMeter>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> pulseAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
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

    if (widget.suspicion >= 70) {
      controller.repeat(
        reverse: true,
      );
    }
  }

  @override
  void didUpdateWidget(
    covariant SuspicionMeter oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (widget.suspicion >= 70 && oldWidget.suspicion < 70) {
      controller.repeat(
        reverse: true,
      );
    }

    if (widget.suspicion < 70 && oldWidget.suspicion >= 70) {
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
  // METER COLOR
  // =========================

  Color get meterColor {
    if (widget.suspicion >= 80) {
      return Colors.red;
    }

    if (widget.suspicion >= 50) {
      return Colors.orange;
    }

    return Colors.green;
  }

  // =========================
  // STATUS
  // =========================

  String get status {
    if (widget.suspicion >= 80) {
      return "CRITICAL";
    }

    if (widget.suspicion >= 50) {
      return "SUSPICIOUS";
    }

    return "SAFE";
  }

  // =========================
  // DESCRIPTION
  // =========================

  String get description {
    if (widget.suspicion >= 80) {
      return "Players are close to exposing the influencer.";
    }

    if (widget.suspicion >= 50) {
      return "Suspicion is rapidly increasing among players.";
    }

    return "Influencer identity remains hidden.";
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final content = Container(
      margin: const EdgeInsets.only(
        top: 22,
      ),
      padding: const EdgeInsets.all(
        24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            meterColor,
            meterColor.withOpacity(
              0.76,
            ),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: meterColor.withOpacity(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Suspicion Meter",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade100,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // VALUE DISPLAY
          // =====================

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.12,
                    ),
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${widget.suspicion}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                            0.16,
                          ),
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                width: 18,
              ),

              // ===================
              // CIRCLE INDICATOR
              // ===================

              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: CircularProgressIndicator(
                      value: widget.suspicion / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation(
                        Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.white,
                        size: 34,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${widget.suspicion}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // BAR
          // =====================

          ClipRRect(
            borderRadius: BorderRadius.circular(
              12,
            ),
            child: LinearProgressIndicator(
              value: widget.suspicion / 100,
              minHeight: 14,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hidden",
                style: TextStyle(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Exposed",
                style: TextStyle(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (!widget.animated) {
      return content;
    }

    return ScaleTransition(
      scale: pulseAnimation,
      child: content,
    );
  }
}
