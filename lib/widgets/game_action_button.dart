import 'package:flutter/material.dart';

class GameActionButton extends StatelessWidget {
  final String text;

  final IconData icon;

  final VoidCallback? onPressed;

  final List<Color> colors;

  final bool loading;

  final bool expanded;

  final double height;

  final double borderRadius;

  final double fontSize;

  final double iconSize;

  const GameActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.colors = const [
      Colors.indigo,
      Colors.deepPurple,
    ],
    this.loading = false,
    this.expanded = true,
    this.height = 62,
    this.borderRadius = 24,
    this.fontSize = 16,
    this.iconSize = 26,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final disabled = onPressed == null || loading;

    final button = ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: disabled
                ? [
                    Colors.grey.shade700,
                    Colors.grey.shade800,
                  ]
                : colors,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          boxShadow: disabled
              ? []
              : [
                  BoxShadow(
                    color: colors.first.withOpacity(
                      0.24,
                    ),
                    blurRadius: 16,
                    offset: const Offset(
                      0,
                      8,
                    ),
                  ),
                ],
        ),
        child: Container(
          width: expanded ? double.infinity : null,
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Row(
            mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // =================
              // LOADING / ICON
              // =================

              if (loading)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                  ),
                )
              else
                Icon(
                  icon,
                  color: Colors.white,
                  size: iconSize,
                ),

              const SizedBox(
                width: 14,
              ),

              // =================
              // TEXT
              // =================

              Flexible(
                child: Text(
                  loading ? "Processing..." : text,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (expanded) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}
