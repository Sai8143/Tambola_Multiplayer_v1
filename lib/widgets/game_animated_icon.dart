import 'package:flutter/material.dart';

class GameAnimatedIcon extends StatefulWidget {
  final IconData icon;

  final double size;

  final Color color;

  final Duration duration;

  const GameAnimatedIcon({
    super.key,
    required this.icon,
    this.size = 60,
    this.color = Colors.indigo,
    this.duration = const Duration(
      milliseconds: 1200,
    ),
  });

  @override
  State<GameAnimatedIcon> createState() => _GameAnimatedIconState();
}

class _GameAnimatedIconState extends State<GameAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scaleAnimation;

  late Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    rotationAnimation = Tween<double>(
      begin: -0.03,
      end: 0.03,
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

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimatedBuilder(
      animation: controller,
      builder: (
        context,
        child,
      ) {
        return Transform.rotate(
          angle: rotationAnimation.value,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Container(
              width: widget.size + 28,
              height: widget.size + 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(
                  0.12,
                ),
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: widget.size,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
