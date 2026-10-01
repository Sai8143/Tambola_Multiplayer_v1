import 'package:flutter/material.dart';

class AdminNumberGeneratorCard extends StatefulWidget {
  final int? currentNumber;

  final bool generating;

  final VoidCallback onGenerate;

  final List<int> remainingNumbers;

  const AdminNumberGeneratorCard({
    super.key,
    required this.currentNumber,
    required this.generating,
    required this.onGenerate,
    required this.remainingNumbers,
  });

  @override
  State<AdminNumberGeneratorCard> createState() =>
      _AdminNumberGeneratorCardState();
}

class _AdminNumberGeneratorCardState extends State<AdminNumberGeneratorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotateAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    rotateAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    if (widget.generating) {
      controller.repeat();
    }
  }

  @override
  void didUpdateWidget(
    covariant AdminNumberGeneratorCard oldWidget,
  ) {
    super.didUpdateWidget(
      oldWidget,
    );

    if (widget.generating && !oldWidget.generating) {
      controller.repeat();
    }

    if (!widget.generating && oldWidget.generating) {
      controller.stop();
    }
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
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
        24,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF111827),
            Color(0xFF1F2937),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          30,
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
                width: 60,
                height: 60,
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
                  size: 32,
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
                      "Number Generator",
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
                      "Generate live match numbers",
                      style: TextStyle(
                        color: Colors.white70,
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
                  color: Colors.green.withOpacity(
                    0.14,
                  ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Text(
                  "${widget.remainingNumbers.length} LEFT",
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 34,
          ),

          // =====================
          // NUMBER DISPLAY
          // =====================

          RotationTransition(
            turns: rotateAnimation,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.indigo,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(
                      0.26,
                    ),
                    blurRadius: 22,
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
                    widget.currentNumber?.toString() ?? "--",
                    key: ValueKey(
                      widget.currentNumber,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 68,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 34,
          ),

          // =====================
          // STATUS
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
                  widget.generating ? Icons.sync : Icons.check_circle,
                  color: widget.generating ? Colors.orange : Colors.green,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    widget.generating
                        ? "Generating next number..."
                        : "Ready to generate next number.",
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
            height: 28,
          ),

          // =====================
          // GENERATE BUTTON
          // =====================

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.generating ? null : widget.onGenerate,
              icon: Icon(
                widget.generating ? Icons.sync : Icons.casino,
              ),
              label: Text(
                widget.generating ? "Generating..." : "Generate Number",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade700,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
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
            ),
          ),
        ],
      ),
    );
  }
}
