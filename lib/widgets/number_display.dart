import 'package:flutter/material.dart';

class NumberDisplay extends StatefulWidget {
  final int? current;

  final bool autoMark;

  final bool isAdmin;

  final bool isInfluenced;

  final Function(bool value) onAutoMarkChanged;

  const NumberDisplay({
    super.key,
    required this.current,
    required this.autoMark,
    required this.onAutoMarkChanged,
    required this.isAdmin,
    this.isInfluenced = false,
  });

  @override
  State<NumberDisplay> createState() => _NumberDisplayState();
}

class _NumberDisplayState extends State<NumberDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    controller.forward();
  }

  @override
  void didUpdateWidget(
    covariant NumberDisplay oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (oldWidget.current != widget.current) {
      controller.forward(
        from: 0,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  // =========================
  // NUMBER COLOR
  // =========================

  List<Color> get numberColors {
    if (widget.isInfluenced) {
      return [
        Colors.red,
        Colors.deepPurple,
      ];
    }

    return [
      Colors.deepPurple,
      Colors.indigo,
    ];
  }

  // =========================
  // STATUS LABEL
  // =========================

  String get statusLabel {
    if (widget.current == null) {
      return "WAITING";
    }

    if (widget.isInfluenced) {
      return "MANIPULATED";
    }

    return "LIVE";
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
        26,
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
          32,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
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
      child: Column(
        children: [
          // =====================
          // HEADER
          // =====================

          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
                child: const Icon(
                  Icons.casino,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Number",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Live number broadcast",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: widget.isInfluenced
                      ? Colors.red.withOpacity(
                          0.16,
                        )
                      : Colors.green.withOpacity(
                          0.16,
                        ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: widget.isInfluenced
                        ? Colors.redAccent
                        : Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 32,
          ),

          // =====================
          // NUMBER DISPLAY
          // =====================

          ScaleTransition(
            scale: scaleAnimation,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: numberColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: numberColors.first.withOpacity(
                      0.4,
                    ),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  child: Text(
                    widget.current?.toString() ?? "--",
                    key: ValueKey(
                      widget.current,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          // =====================
          // NUMBER STATUS
          // =====================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              18,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.06,
              ),
              borderRadius: BorderRadius.circular(
                22,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  widget.isInfluenced ? Icons.warning : Icons.wifi_tethering,
                  color: widget.isInfluenced
                      ? Colors.redAccent
                      : Colors.greenAccent,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    widget.current == null
                        ? "Waiting for admin to generate next number."
                        : widget.isInfluenced
                            ? "Influencer interference detected in current round."
                            : "Number successfully broadcasted to all players.",
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          // =====================
          // AUTO MARK
          // =====================

          if (!widget.isAdmin)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.08,
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.touch_app,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Expanded(
                    child: Text(
                      "Auto Mark Numbers",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Switch(
                    value: widget.autoMark,
                    onChanged: widget.onAutoMarkChanged,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
