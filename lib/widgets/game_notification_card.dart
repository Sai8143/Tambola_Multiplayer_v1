import 'package:flutter/material.dart';

class GameNotificationCard extends StatefulWidget {
  final bool visible;

  final String title;

  final String message;

  final IconData icon;

  final Color color;

  const GameNotificationCard({
    super.key,
    required this.visible,
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
  });

  @override
  State<GameNotificationCard> createState() => _GameNotificationCardState();
}

class _GameNotificationCardState extends State<GameNotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> fadeAnimation;

  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 450,
      ),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(
        0,
        -0.15,
      ),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    if (widget.visible) {
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(
    covariant GameNotificationCard oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (widget.visible && !oldWidget.visible) {
      controller.forward(
        from: 0,
      );
    }

    if (!widget.visible && oldWidget.visible) {
      controller.reverse();
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
    if (!widget.visible) {
      return const SizedBox();
    }

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: 22,
          ),
          padding: const EdgeInsets.all(
            22,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.color,
                widget.color.withOpacity(
                  0.72,
                ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              28,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(
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
              // ICON
              // ===================

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
                    // TITLE
                    // ===============

                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
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
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    // ===============
                    // CHIP
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
                      child: const Text(
                        "LIVE UPDATE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
