import 'package:flutter/material.dart';

class InfluenceHeatBanner extends StatefulWidget {
  final int heat;

  final String? warning;

  final bool animated;

  const InfluenceHeatBanner({
    super.key,
    required this.heat,
    required this.warning,
    this.animated = true,
  });

  @override
  State<InfluenceHeatBanner> createState() => _InfluenceHeatBannerState();
}

class _InfluenceHeatBannerState extends State<InfluenceHeatBanner>
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

    if (widget.heat >= 80) {
      controller.repeat(
        reverse: true,
      );
    }
  }

  @override
  void didUpdateWidget(
    covariant InfluenceHeatBanner oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (widget.heat >= 80 && oldWidget.heat < 80) {
      controller.repeat(
        reverse: true,
      );
    }

    if (widget.heat < 80 && oldWidget.heat >= 80) {
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
  // BANNER COLOR
  // =========================

  Color get bannerColor {
    if (widget.heat >= 80) {
      return Colors.red;
    }

    if (widget.heat >= 50) {
      return Colors.orange;
    }

    return Colors.deepPurple;
  }

  // =========================
  // ICON
  // =========================

  IconData get bannerIcon {
    if (widget.heat >= 80) {
      return Icons.warning_rounded;
    }

    if (widget.heat >= 50) {
      return Icons.visibility;
    }

    return Icons.psychology;
  }

  // =========================
  // STATUS LABEL
  // =========================

  String get statusLabel {
    if (widget.heat >= 80) {
      return "CRITICAL";
    }

    if (widget.heat >= 50) {
      return "SUSPICIOUS";
    }

    return "STABLE";
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    if (widget.warning == null) {
      return const SizedBox();
    }

    final content = Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 18,
      ),
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bannerColor,
            bannerColor.withOpacity(
              0.76,
            ),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          26,
        ),
        boxShadow: [
          BoxShadow(
            color: bannerColor.withOpacity(
              0.26,
            ),
            blurRadius: 18,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================
          // ICON
          // =====================

          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.14,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              bannerIcon,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          // =====================
          // CONTENT
          // =====================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "INFLUENCE ALERT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.14,
                        ),
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                      child: Text(
                        statusLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  widget.warning!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // =================
                // HEAT BAR
                // =================

                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  child: LinearProgressIndicator(
                    value: widget.heat / 100,
                    minHeight: 10,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Heat Level: ${widget.heat}%",
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
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
