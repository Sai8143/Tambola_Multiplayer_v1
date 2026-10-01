import 'package:flutter/material.dart';

class GameLoadingOverlay extends StatelessWidget {
  final bool visible;

  final String message;

  const GameLoadingOverlay({
    super.key,
    required this.visible,
    this.message = "Loading Match...",
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    if (!visible) {
      return const SizedBox();
    }

    return Container(
      color: Colors.black.withOpacity(
        0.72,
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(
            28,
          ),
          padding: const EdgeInsets.all(
            30,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1E1B4B),
                Color(0xFF312E81),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              34,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  0.30,
                ),
                blurRadius: 22,
                offset: const Offset(
                  0,
                  10,
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ===================
              // LOADER
              // ===================

              const SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: CircularProgressIndicator(
                        strokeWidth: 7,
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                        backgroundColor: Colors.white12,
                      ),
                    ),
                    Icon(
                      Icons.casino,
                      color: Colors.white,
                      size: 42,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // ===================
              // TITLE
              // ===================

              const Text(
                "Please Wait",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // ===================
              // MESSAGE
              // ===================

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              // ===================
              // STATUS CHIP
              // ===================

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.12,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: const Text(
                  "SYNCING GAME STATE",
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
      ),
    );
  }
}
