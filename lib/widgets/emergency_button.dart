import 'package:flutter/material.dart';

class EmergencyButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;
  final bool meetingActive;
  final int cooldownSeconds;
  final bool compact;

  const EmergencyButton({
    super.key,
    required this.onTap,
    this.enabled = true,
    this.meetingActive = false,
    this.cooldownSeconds = 0,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = !enabled || meetingActive || cooldownSeconds > 0;

    if (compact) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: disabled
                ? [Colors.grey.shade700, Colors.grey.shade800]
                : const [Color(0xFFFF4D4D), Color(0xFFB31217)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.28),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: disabled ? null : onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    disabled ? "LOCKED" : "EMERGENCY",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.28),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onTap,
          borderRadius: BorderRadius.circular(28),
          child: Ink(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: disabled
                    ? [Colors.grey.shade700, Colors.grey.shade800]
                    : const [Color(0xFFFF4D4D), Color(0xFFB31217)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TOP ICON
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(disabled ? 0.10 : 0.18),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.28),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.warning_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),

                const SizedBox(height: 20),

                // TITLE
                const Text(
                  "Emergency Meeting",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 10),

                // DESCRIPTION
                Text(
                  meetingActive
                      ? "An emergency discussion is already in progress."
                      : cooldownSeconds > 0
                          ? "Emergency system cooling down."
                          : "Call all active players for an emergency voting session.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 22),

                // STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        disabled ? Icons.lock_clock : Icons.campaign,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          buildStatusText(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // BUTTON
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 52,
                  decoration: BoxDecoration(
                    color: disabled ? Colors.white.withOpacity(0.10) : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      disabled ? "UNAVAILABLE" : "START MEETING",
                      style: TextStyle(
                        color: disabled ? Colors.white70 : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
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

  String buildStatusText() {
    if (meetingActive) {
      return "Emergency meeting already active.";
    }

    if (cooldownSeconds > 0) {
      return "Cooldown active • $cooldownSeconds sec remaining";
    }

    if (!enabled) {
      return "Meeting system currently disabled.";
    }

    return "Tap to alert all players and begin voting.";
  }
}
