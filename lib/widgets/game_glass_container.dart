import 'dart:ui';

import 'package:flutter/material.dart';

class GameGlassContainer extends StatelessWidget {
  final Widget child;

  final EdgeInsets padding;

  final double borderRadius;

  final double blur;

  const GameGlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(
      22,
    ),
    this.borderRadius = 30,
    this.blur = 14,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              0.12,
            ),
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
            border: Border.all(
              color: Colors.white.withOpacity(
                0.16,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
