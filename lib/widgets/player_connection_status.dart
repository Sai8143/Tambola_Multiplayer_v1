import 'package:flutter/material.dart';

class PlayerConnectionStatus extends StatelessWidget {
  final bool connected;

  final int latency;

  final String serverName;

  const PlayerConnectionStatus({
    super.key,
    required this.connected,
    required this.latency,
    required this.serverName,
  });

  // =========================
  // STATUS TEXT
  // =========================

  String get statusText {
    return connected ? "CONNECTED" : "DISCONNECTED";
  }

  // =========================
  // STATUS COLOR
  // =========================

  Color get statusColor {
    return connected ? Colors.green : Colors.red;
  }

  // =========================
  // SIGNAL ICON
  // =========================

  IconData get signalIcon {
    if (!connected) {
      return Icons.signal_wifi_off;
    }

    if (latency <= 80) {
      return Icons.network_wifi;
    }

    if (latency <= 150) {
      return Icons.wifi_2_bar;
    }

    return Icons.wifi_1_bar;
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
          30,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.06,
            ),
            blurRadius: 14,
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

          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      statusColor,
                      connected ? Colors.teal : Colors.deepOrange,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: Icon(
                  signalIcon,
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
                      "Connection Status",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Live server connection",
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
                  color: statusColor.withOpacity(
                    0.10,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // SERVER INFO
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  statusColor.withOpacity(
                    0.08,
                  ),
                  statusColor.withOpacity(
                    0.03,
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.dns,
                      color: Colors.indigo,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        "Server",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      serverName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Icon(
                      signalIcon,
                      color: statusColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        "Latency",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "$latency ms",
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  child: LinearProgressIndicator(
                    value: connected
                        ? (1 - (latency / 300)).clamp(
                            0,
                            1,
                          )
                        : 0,
                    minHeight: 14,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(
                      statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 28,
          ),

          // =====================
          // FOOTER
          // =====================

          Container(
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
              children: [
                Icon(
                  connected ? Icons.check_circle : Icons.error,
                  color: statusColor,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    connected
                        ? "Stable connection established with the live game server."
                        : "Unable to connect with the server. Retry connection.",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
