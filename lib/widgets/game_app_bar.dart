import 'package:flutter/material.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final int currentRound;

  final bool gameLive;

  final VoidCallback onBack;

  final VoidCallback onInfo;

  const GameAppBar({
    super.key,
    required this.title,
    required this.currentRound,
    required this.gameLive,
    required this.onBack,
    required this.onInfo,
  });

  @override
  Size get preferredSize => const Size.fromHeight(
        82,
      );

  @override
  Widget build(
    BuildContext context,
  ) {
    final width = MediaQuery.of(context).size.width;

    final mobile = width < 700;

    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(
                0xFF312E81,
              ),
              Color(
                0xFF4338CA,
              ),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Container(
            height: mobile ? 72 : 82,
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 14 : 22,
            ),
            child: Row(
              children: [
                // =================
                // BACK BUTTON
                // =================

                Container(
                  width: mobile ? 48 : 56,
                  height: mobile ? 48 : 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.10,
                    ),
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: IconButton(
                    onPressed: onBack,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: mobile ? 24 : 28,
                    ),
                  ),
                ),

                SizedBox(
                  width: mobile ? 12 : 18,
                ),

                // =================
                // TITLE AREA
                // =================

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: mobile ? 24 : 30,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          // LIVE

                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(
                                0xFF6EE7B7,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          Text(
                            gameLive ? "LIVE MATCH" : "OFFLINE",
                            style: TextStyle(
                              color: Colors.white.withOpacity(
                                0.90,
                              ),
                              fontWeight: FontWeight.w700,
                              fontSize: mobile ? 12 : 14,
                              letterSpacing: 0.8,
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          // ROUND

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: mobile ? 10 : 14,
                              vertical: mobile ? 5 : 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.12,
                              ),
                              borderRadius: BorderRadius.circular(
                                14,
                              ),
                            ),
                            child: Text(
                              "ROUND $currentRound",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: mobile ? 11 : 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: mobile ? 10 : 16,
                ),

                // =================
                // INFO BUTTON
                // =================

                Container(
                  width: mobile ? 48 : 56,
                  height: mobile ? 48 : 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.10,
                    ),
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: IconButton(
                    onPressed: onInfo,
                    icon: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: mobile ? 24 : 28,
                    ),
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
