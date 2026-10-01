import 'package:flutter/material.dart';

class GameBottomNavigation extends StatelessWidget {
  final int currentIndex;

  final Function(int index) onTap;

  const GameBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final items = [
      {
        'icon': Icons.home_rounded,
        'label': 'Home',
      },
      {
        'icon': Icons.grid_view_rounded,
        'label': 'Ticket',
      },
      {
        'icon': Icons.psychology,
        'label': 'Predictions',
      },
      {
        'icon': Icons.leaderboard,
        'label': 'Stats',
      },
      {
        'icon': Icons.settings,
        'label': 'Settings',
      },
    ];

    return Container(
      height: 92,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            30,
          ),
          topRight: Radius.circular(
            30,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.08,
            ),
            blurRadius: 18,
            offset: const Offset(
              0,
              -4,
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (
            index,
          ) {
            final item = items[index];

            final bool active = currentIndex == index;

            return GestureDetector(
              onTap: () {
                onTap(index);
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 220,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: active
                      ? const LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.indigo,
                          ],
                        )
                      : null,
                  color: active ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: active ? Colors.white : Colors.grey.shade600,
                      size: 28,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        color: active ? Colors.white : Colors.grey.shade700,
                        fontWeight: active ? FontWeight.bold : FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
