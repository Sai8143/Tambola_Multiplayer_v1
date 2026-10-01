import 'package:flutter/material.dart';

class InfluenceActivityFeed extends StatelessWidget {
  final List<String> logs;

  final bool showHeader;

  const InfluenceActivityFeed({
    super.key,
    required this.logs,
    this.showHeader = true,
  });

  // =========================
  // FEED COLOR
  // =========================

  Color logColor(
    String log,
  ) {
    final value = log.toLowerCase();

    if (value.contains(
          'warning',
        ) ||
        value.contains(
          'critical',
        ) ||
        value.contains(
          'eliminated',
        )) {
      return Colors.red;
    }

    if (value.contains(
      'prediction',
    )) {
      return Colors.deepPurple;
    }

    if (value.contains(
          'meeting',
        ) ||
        value.contains(
          'vote',
        )) {
      return Colors.orange;
    }

    if (value.contains(
          'success',
        ) ||
        value.contains(
          'exposed',
        )) {
      return Colors.green;
    }

    return Colors.indigo;
  }

  // =========================
  // FEED ICON
  // =========================

  IconData logIcon(
    String log,
  ) {
    final value = log.toLowerCase();

    if (value.contains(
      'prediction',
    )) {
      return Icons.psychology;
    }

    if (value.contains(
      'meeting',
    )) {
      return Icons.groups;
    }

    if (value.contains(
      'vote',
    )) {
      return Icons.how_to_vote;
    }

    if (value.contains(
          'success',
        ) ||
        value.contains(
          'winner',
        )) {
      return Icons.check_circle;
    }

    if (value.contains(
          'warning',
        ) ||
        value.contains(
          'critical',
        )) {
      return Icons.warning;
    }

    return Icons.bolt;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        top: 22,
      ),
      padding: const EdgeInsets.all(
        22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          28,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.06,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              6,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================
          // HEADER
          // =====================

          if (showHeader)
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.deepPurple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: const Icon(
                    Icons.bolt,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Influence Activity",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Live suspicious activity feed",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(
                      0.08,
                    ),
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Text(
                    logs.length.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

          if (showHeader)
            const SizedBox(
              height: 24,
            ),

          // =====================
          // EMPTY
          // =====================

          if (logs.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 36,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.visibility_off,
                    size: 42,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "No suspicious activity yet",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

          // =====================
          // LOGS
          // =====================

          if (logs.isNotEmpty)
            ListView.separated(
              itemCount: logs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (
                _,
                __,
              ) =>
                  const SizedBox(
                height: 14,
              ),
              itemBuilder: (
                context,
                index,
              ) {
                final log = logs[index];

                final color = logColor(
                  log,
                );

                final icon = logIcon(
                  log,
                );

                final bool latest = index == 0;

                return AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  padding: const EdgeInsets.all(
                    18,
                  ),
                  decoration: BoxDecoration(
                    gradient: latest
                        ? LinearGradient(
                            colors: [
                              color.withOpacity(
                                0.12,
                              ),
                              color.withOpacity(
                                0.04,
                              ),
                            ],
                          )
                        : LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade50,
                            ],
                          ),
                    borderRadius: BorderRadius.circular(
                      22,
                    ),
                    border: Border.all(
                      color: latest
                          ? color.withOpacity(
                              0.2,
                            )
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =================
                      // ICON
                      // =================

                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: color.withOpacity(
                            0.12,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: color,
                          size: 28,
                        ),
                      ),

                      const SizedBox(
                        width: 14,
                      ),

                      // =================
                      // TEXT
                      // =================

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    latest ? "LATEST EVENT" : "EVENT",
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                if (latest)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: const Text(
                                      "LIVE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              log,
                              style: const TextStyle(
                                height: 1.5,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
