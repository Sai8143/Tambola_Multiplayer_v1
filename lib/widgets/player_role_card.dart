import 'package:flutter/material.dart';

import '../models/player_role.dart';

class PlayerRoleCard extends StatefulWidget {
  final PlayerRole role;

  final bool revealRole;

  final bool animated;

  final VoidCallback? onRevealCompleted;

  const PlayerRoleCard({
    super.key,
    required this.role,
    required this.revealRole,
    this.animated = true,
    this.onRevealCompleted,
  });

  @override
  State<PlayerRoleCard> createState() => _PlayerRoleCardState();
}

class _PlayerRoleCardState extends State<PlayerRoleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scaleAnimation;

  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    if (widget.animated) {
      controller.forward().then(
        (_) {
          widget.onRevealCompleted?.call();
        },
      );
    } else {
      controller.value = 1;
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
    final bool influencer = widget.role == PlayerRole.influencer;

    final List<Color> colors = influencer
        ? [
            Colors.red,
            Colors.deepPurple,
          ]
        : [
            Colors.indigo,
            Colors.blue,
          ];

    return FadeTransition(
      opacity: opacityAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(
            30,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              34,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.first.withOpacity(
                  0.35,
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
              // ROLE ICON
              // =====================

              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 400,
                ),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(
                    0.14,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.revealRole ? getEmoji() : "❓",
                    style: const TextStyle(
                      fontSize: 88,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              // =====================
              // ROLE TITLE
              // =====================

              Text(
                widget.revealRole ? getTitle() : "Hidden Role",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              // =====================
              // DESCRIPTION
              // =====================

              Text(
                widget.revealRole
                    ? getDescription()
                    : "Decrypting player identity...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade100,
                  fontSize: 17,
                  height: 1.7,
                ),
              ),

              const SizedBox(
                height: 34,
              ),

              // =====================
              // ABILITIES
              // =====================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  22,
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
                  children: getAbilities().map(
                    (ability) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                ability,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              // =====================
              // WARNING
              // =====================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  18,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                    0.15,
                  ),
                  borderRadius: BorderRadius.circular(
                    22,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        influencer
                            ? "Do not reveal your identity. Use influence carefully to avoid suspicion."
                            : "Watch suspicious behavior and vote carefully during emergency meetings.",
                        style: TextStyle(
                          color: Colors.grey.shade100,
                          height: 1.5,
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

  // =========================
  // TITLE
  // =========================

  String getTitle() {
    switch (widget.role) {
      case PlayerRole.influencer:
        return "INFLUENCER";

      case PlayerRole.normal:
        return "NORMAL PLAYER";
    }
  }

  // =========================
  // DESCRIPTION
  // =========================

  String getDescription() {
    switch (widget.role) {
      case PlayerRole.influencer:
        return "Manipulate fate secretly, increase chaos, and survive accusations.";

      case PlayerRole.normal:
        return "Complete your ticket, monitor suspicious activity, and expose the hidden influencer.";
    }
  }

  // =========================
  // EMOJI
  // =========================

  String getEmoji() {
    switch (widget.role) {
      case PlayerRole.influencer:
        return "🕵️";

      case PlayerRole.normal:
        return "🎟";
    }
  }

  // =========================
  // ABILITIES
  // =========================

  List<String> getAbilities() {
    switch (widget.role) {
      case PlayerRole.influencer:
        return [
          "Delay upcoming numbers",
          "Swap future numbers secretly",
          "Jam prediction systems",
          "Increase chaos heat carefully",
        ];

      case PlayerRole.normal:
        return [
          "Mark called numbers",
          "Use predictions strategically",
          "Observe suspicious actions",
          "Vote during emergency meetings",
        ];
    }
  }
}
