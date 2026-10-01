import 'package:flutter/material.dart';

class CalledNumbersSidebar extends StatelessWidget {
  final List<int> calledNumbers;

  final int? currentNumber;

  const CalledNumbersSidebar({
    super.key,
    required this.calledNumbers,
    required this.currentNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        border: Border(
          right: BorderSide(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
      ),
      child: GridView.builder(
        itemCount: 90,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final number = index + 1;

          final bool called = calledNumbers.contains(number);

          final bool current = currentNumber == number;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              gradient: current
                  ? const LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    )
                  : called
                      ? const LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.teal,
                          ],
                        )
                      : LinearGradient(
                          colors: [
                            Colors.grey.shade900,
                            Colors.grey.shade800,
                          ],
                        ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: current
                    ? Colors.orangeAccent
                    : called
                        ? Colors.greenAccent
                        : Colors.white12,
              ),
              boxShadow: current
                  ? [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color:
                      called || current ? Colors.white : Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
