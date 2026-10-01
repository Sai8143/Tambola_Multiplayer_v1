import 'package:flutter/material.dart';

class GameAvatar extends StatelessWidget {
  final String name;

  final double size;

  final bool influencer;

  final bool online;

  final bool eliminated;

  const GameAvatar({
    super.key,
    required this.name,
    this.size = 72,
    this.influencer = false,
    this.online = true,
    this.eliminated = false,
  });

  // =========================
  // COLORS
  // =========================

  List<Color> get colors {
    if (eliminated) {
      return [
        Colors.red,
        Colors.deepOrange,
      ];
    }

    if (influencer) {
      return [
        Colors.deepPurple,
        Colors.red,
      ];
    }

    return [
      Colors.indigo,
      Colors.blue,
    ];
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // =====================
        // AVATAR
        // =====================

        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.first.withOpacity(
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
          child: Center(
            child: Text(
              name
                  .substring(
                    0,
                    1,
                  )
                  .toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // =====================
        // ONLINE STATUS
        // =====================

        if (!eliminated)
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: size * 0.24,
              height: size * 0.24,
              decoration: BoxDecoration(
                color: online ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),

        // =====================
        // ELIMINATED ICON
        // =====================

        if (eliminated)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.32,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
      ],
    );
  }
}
