import 'package:flutter/material.dart';

class GameEmptyState extends StatelessWidget {
  final String title;

  final String subtitle;

  final IconData icon;

  final List<Color> colors;

  final String? buttonText;

  final VoidCallback? onPressed;

  const GameEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.colors = const [
      Colors.indigo,
      Colors.deepPurple,
    ],
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        32,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          32,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.06,
            ),
            blurRadius: 16,
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
          // ===================
          // ICON
          // ===================

          Container(
            width: 140,
            height: 140,
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
                  blurRadius: 18,
                  offset: const Offset(
                    0,
                    10,
                  ),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 72,
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          // ===================
          // TITLE
          // ===================

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          // ===================
          // SUBTITLE
          // ===================

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              height: 1.7,
            ),
          ),

          // ===================
          // BUTTON
          // ===================

          if (buttonText != null && onPressed != null) ...[
            const SizedBox(
              height: 34,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.first,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      22,
                    ),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                child: Text(
                  buttonText!,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
