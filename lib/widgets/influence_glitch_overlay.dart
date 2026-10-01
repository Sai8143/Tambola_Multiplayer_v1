import 'dart:math';

import 'package:flutter/material.dart';

class InfluenceGlitchOverlay extends StatefulWidget {
  final bool active;

  final Widget child;

  const InfluenceGlitchOverlay({
    super.key,
    required this.active,
    required this.child,
  });

  @override
  State<InfluenceGlitchOverlay> createState() => _InfluenceGlitchOverlayState();
}

class _InfluenceGlitchOverlayState extends State<InfluenceGlitchOverlay>
    with TickerProviderStateMixin {
  late AnimationController pulseController;

  late Animation<double> pulseAnimation;

  final Random random = Random();

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    pulseAnimation = Tween<double>(
      begin: 0.02,
      end: 0.08,
    ).animate(
      CurvedAnimation(
        parent: pulseController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.active) {
      pulseController.repeat(
        reverse: true,
      );
    }
  }

  @override
  void didUpdateWidget(
    covariant InfluenceGlitchOverlay oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (widget.active && !oldWidget.active) {
      pulseController.repeat(
        reverse: true,
      );
    }

    if (!widget.active && oldWidget.active) {
      pulseController.stop();
    }
  }

  @override
  void dispose() {
    pulseController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // =====================
    // NORMAL UI
    // =====================

    if (!widget.active) {
      return widget.child;
    }

    // =====================
    // GLITCH UI
    // =====================

    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (
        context,
        child,
      ) {
        final double offset = random.nextDouble() * 3;

        return Stack(
          children: [
            // =================
            // BASE
            // =================

            widget.child,

            // =================
            // RED SHIFT
            // =================

            IgnorePointer(
              child: Transform.translate(
                offset: Offset(
                  offset,
                  0,
                ),
                child: Opacity(
                  opacity: 0.06,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            // =================
            // BLUE SHIFT
            // =================

            IgnorePointer(
              child: Transform.translate(
                offset: Offset(
                  -offset,
                  0,
                ),
                child: Opacity(
                  opacity: 0.04,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            // =================
            // PULSE OVERLAY
            // =================

            IgnorePointer(
              child: Container(
                color: Colors.red.withOpacity(
                  pulseAnimation.value,
                ),
              ),
            ),

            // =================
            // SCAN LINES
            // =================

            IgnorePointer(
              child: CustomPaint(
                painter: _GlitchPainter(
                  opacity: pulseAnimation.value,
                ),
                size: Size.infinite,
              ),
            ),

            // =================
            // WARNING TEXT
            // =================

            Positioned(
              top: 80,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 250,
                ),
                opacity: 0.9,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(
                      0.7,
                    ),
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    border: Border.all(
                      color: Colors.red,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "INFLUENCE DETECTED",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// =========================
// CUSTOM GLITCH PAINTER
// =========================

class _GlitchPainter extends CustomPainter {
  final double opacity;

  _GlitchPainter({
    required this.opacity,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(
        opacity * 0.4,
      )
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 6) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _GlitchPainter oldDelegate,
  ) {
    return oldDelegate.opacity != opacity;
  }
}
