import 'package:flutter/material.dart';

class AnimatedScoreCounter extends StatefulWidget {
  final int score;

  final String label;

  final IconData icon;

  final Color color;

  const AnimatedScoreCounter({
    super.key,
    required this.score,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  State<AnimatedScoreCounter> createState() => _AnimatedScoreCounterState();
}

class _AnimatedScoreCounterState extends State<AnimatedScoreCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<int> scoreAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    );

    scoreAnimation = IntTween(
      begin: 0,
      end: widget.score,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    controller.forward();
  }

  @override
  void didUpdateWidget(
    covariant AnimatedScoreCounter oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (oldWidget.score != widget.score) {
      scoreAnimation = IntTween(
        begin: oldWidget.score,
        end: widget.score,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        ),
      );

      controller.forward(
        from: 0,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimatedBuilder(
      animation: scoreAnimation,
      builder: (
        context,
        child,
      ) {
        return Container(
          padding: const EdgeInsets.all(
            20,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.color,
                widget.color.withOpacity(
                  0.72,
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(
              28,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(
                  0.22,
                ),
                blurRadius: 14,
                offset: const Offset(
                  0,
                  8,
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =================
              // ICON
              // =================

              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.14,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 34,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // =================
              // SCORE
              // =================

              Text(
                scoreAnimation.value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              // =================
              // LABEL
              // =================

              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
