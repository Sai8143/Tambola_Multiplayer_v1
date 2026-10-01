import 'package:flutter/material.dart';

class GameSearchBar extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onClear;

  const GameSearchBar({
    super.key,
    required this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          24,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              6,
            ),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),

          // ===================
          // PREFIX
          // ===================

          prefixIcon: const Icon(
            Icons.search,
            color: Colors.indigo,
          ),

          // ===================
          // HINT
          // ===================

          hintText: hintText,

          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),

          // ===================
          // SUFFIX
          // ===================

          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear();

                    if (onClear != null) {
                      onClear!();
                    }
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
