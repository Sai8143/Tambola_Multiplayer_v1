import 'package:flutter/material.dart';

class GameDrawer extends StatelessWidget {
  final String playerName;

  final bool influencer;

  final VoidCallback onProfile;

  final VoidCallback onRules;

  final VoidCallback onStatistics;

  final VoidCallback onSettings;

  final VoidCallback onLogout;

  const GameDrawer({
    super.key,
    required this.playerName,
    required this.influencer,
    required this.onProfile,
    required this.onRules,
    required this.onStatistics,
    required this.onSettings,
    required this.onLogout,
  });

  // =========================
  // ROLE COLORS
  // =========================

  List<Color> get roleColors {
    if (influencer) {
      return [
        Colors.red,
        Colors.deepPurple,
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
    return Drawer(
      child: Column(
        children: [
          // =====================
          // HEADER
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 60,
              bottom: 30,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: roleColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =================
                // AVATAR
                // =================

                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.14,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      playerName
                          .substring(
                            0,
                            1,
                          )
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // =================
                // NAME
                // =================

                Text(
                  playerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                // =================
                // ROLE CHIP
                // =================

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
                  child: Text(
                    influencer ? "INFLUENCER" : "PLAYER",
                    style: const TextStyle(
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

          // =====================
          // MENU ITEMS
          // =====================

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(
                16,
              ),
              children: [
                buildMenuTile(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: onProfile,
                ),
                buildMenuTile(
                  icon: Icons.menu_book,
                  title: "Game Rules",
                  onTap: onRules,
                ),
                buildMenuTile(
                  icon: Icons.bar_chart,
                  title: "Statistics",
                  onTap: onStatistics,
                ),
                buildMenuTile(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: onSettings,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey.shade300,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildMenuTile(
                  icon: Icons.logout,
                  title: "Logout",
                  color: Colors.red,
                  onTap: onLogout,
                ),
              ],
            ),
          ),

          // =====================
          // FOOTER
          // =====================

          Padding(
            padding: const EdgeInsets.all(
              20,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                18,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  22,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.indigo,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Text(
                      "Every 10 numbers automatically advances the next round.",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // MENU TILE
  // =========================

  Widget buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            20,
          ),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(
              18,
            ),
            decoration: BoxDecoration(
              color: color == Colors.red
                  ? Colors.red.withOpacity(
                      0.06,
                    )
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(
                      0.12,
                    ),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: color.withOpacity(
                    0.7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
