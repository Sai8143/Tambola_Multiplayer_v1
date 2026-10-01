import 'package:flutter/material.dart';

class GameGradientBackground extends StatelessWidget {
  final Widget child;

  final bool dark;

  const GameGradientBackground({
    super.key,
    required this.child,
    this.dark = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: dark
              ? [
                  const Color(
                    0xFF0F172A,
                  ),
                  const Color(
                    0xFF111827,
                  ),
                  const Color(
                    0xFF1E293B,
                  ),
                ]
              : [
                  const Color(
                    0xFFF8FAFC,
                  ),
                  const Color(
                    0xFFF1F5F9,
                  ),
                  const Color(
                    0xFFE2E8F0,
                  ),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // ===================
          // TOP CIRCLE
          // ===================

          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dark
                    ? Colors.deepPurple.withOpacity(
                        0.10,
                      )
                    : Colors.indigo.withOpacity(
                        0.08,
                      ),
              ),
            ),
          ),

          // ===================
          // BOTTOM CIRCLE
          // ===================

          Positioned(
            bottom: -140,
            left: -90,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dark
                    ? Colors.red.withOpacity(
                        0.08,
                      )
                    : Colors.deepPurple.withOpacity(
                        0.06,
                      ),
              ),
            ),
          ),

          // ===================
          // CENTER BLUR
          // ===================

          Positioned(
            top: 180,
            left: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dark
                    ? Colors.blue.withOpacity(
                        0.05,
                      )
                    : Colors.blue.withOpacity(
                        0.04,
                      ),
              ),
            ),
          ),

          // ===================
          // CONTENT
          // ===================

          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
