// import 'package:flutter/material.dart';

// class TicketGrid extends StatelessWidget {
//   final List<List<int?>> ticket;

//   final Set<int> calledNumbers;

//   final Function(int number) onTap;

//   const TicketGrid({
//     super.key,
//     required this.ticket,
//     required this.calledNumbers,
//     required this.onTap,
//   });

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Column(
//       children: ticket.map(
//         (row) {
//           return Padding(
//             padding: const EdgeInsets.only(
//               bottom: 10,
//             ),
//             child: Row(
//               children: row.map(
//                 (number) {
//                   return Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(
//                         4,
//                       ),
//                       child: buildCell(
//                         number,
//                       ),
//                     ),
//                   );
//                 },
//               ).toList(),
//             ),
//           );
//         },
//       ).toList(),
//     );
//   }

//   // =========================
//   // CELL
//   // =========================

//   Widget buildCell(
//     int? number,
//   ) {
//     // EMPTY CELL

//     if (number == null) {
//       return Container(
//         height: 58,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(
//             14,
//           ),
//         ),
//       );
//     }

//     final marked = calledNumbers.contains(
//       number,
//     );

//     return GestureDetector(
//       onTap: () {
//         onTap(number);
//       },
//       child: AnimatedContainer(
//         duration: const Duration(
//           milliseconds: 220,
//         ),
//         height: 58,
//         decoration: BoxDecoration(
//           gradient: marked
//               ? const LinearGradient(
//                   colors: [
//                     Colors.green,
//                     Colors.teal,
//                   ],
//                 )
//               : LinearGradient(
//                   colors: [
//                     Colors.white,
//                     Colors.grey.shade100,
//                   ],
//                 ),
//           borderRadius: BorderRadius.circular(
//             14,
//           ),
//           border: Border.all(
//             color: marked ? Colors.green : Colors.grey.shade300,
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(
//                 0.06,
//               ),
//               blurRadius: 6,
//               offset: const Offset(
//                 0,
//                 3,
//               ),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             number.toString(),
//             style: TextStyle(
//               color: marked ? Colors.white : Colors.black87,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ========================================
// UPDATED TICKET GRID
// ========================================

import 'package:flutter/material.dart';

class TicketGrid extends StatelessWidget {
  final List<List<int?>> ticket;
  final Set<int> markedNumbers;
  final Function(int number) onTap;
  final bool interactive;
  final bool revealUpcoming;
  final List<int> upcomingNumbers;
  final bool compact;

  const TicketGrid({
    super.key,
    required this.ticket,
    required this.markedNumbers,
    required this.onTap,
    this.interactive = true,
    this.revealUpcoming = false,
    this.upcomingNumbers = const [],
    this.compact = false,
  });

  bool isMarked(int number) {
    return markedNumbers.contains(number);
  }

  bool isUpcoming(int number) {
    return revealUpcoming && upcomingNumbers.contains(number);
  }

  @override
  Widget build(BuildContext context) {
    final double cellHeight = compact ? 34.0 : 52.0;
    final double headerIconSize = compact ? 32.0 : 56.0;
    final double titleFontSize = compact ? 16.0 : 24.0;
    final double numberFontSize = compact ? 13.0 : 18.0;

    return Container(
      margin: EdgeInsets.only(top: compact ? 4 : 22),
      padding: EdgeInsets.all(compact ? 10 : 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(compact ? 18 : 30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: compact ? 6 : 14,
            offset: Offset(0, compact ? 3 : 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // HEADER
          Row(
            children: [
              Container(
                width: headerIconSize,
                height: headerIconSize,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo],
                  ),
                  borderRadius: BorderRadius.circular(compact ? 10 : 18),
                ),
                child: Icon(
                  Icons.grid_view_rounded,
                  color: Colors.white,
                  size: compact ? 18 : 30,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fate Ticket",
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!compact) ...[
                      const SizedBox(height: 2),
                      const Text(
                        "Tap numbers to mark them",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 10 : 14,
                  vertical: compact ? 4 : 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(compact ? 10 : 16),
                ),
                child: Text(
                  "${markedNumbers.length}",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: compact ? 12 : 14,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: compact ? 10 : 26),

          // COLUMN LABELS
          Row(
            children: List.generate(
              9,
              (index) {
                final labels = [
                  "1-10",
                  "11-20",
                  "21-30",
                  "31-40",
                  "41-50",
                  "51-60",
                  "61-70",
                  "71-80",
                  "81-90",
                ];

                return Expanded(
                  child: Center(
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: compact ? 8 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: compact ? 6 : 14),

          // GRID
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              ticket.length,
              (rowIndex) {
                return Padding(
                  padding: EdgeInsets.only(bottom: compact ? 6 : 10),
                  child: Row(
                    children: List.generate(
                      ticket[rowIndex].length,
                      (colIndex) {
                        final value = ticket[rowIndex][colIndex];

                        if (value == null) {
                          return Expanded(
                            child: Container(
                              height: cellHeight,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(compact ? 8 : 14),
                              ),
                            ),
                          );
                        }

                        final marked = isMarked(value);
                        final upcoming = isUpcoming(value);

                        return Expanded(
                          child: GestureDetector(
                            onTap: interactive ? () => onTap(value) : null,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              height: cellHeight,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                gradient: marked
                                    ? const LinearGradient(
                                        colors: [Colors.green, Colors.teal],
                                      )
                                    : upcoming
                                        ? const LinearGradient(
                                            colors: [Colors.red, Colors.deepPurple],
                                          )
                                        : LinearGradient(
                                            colors: [
                                              Colors.grey.shade100,
                                              Colors.grey.shade50,
                                            ],
                                          ),
                                borderRadius: BorderRadius.circular(compact ? 8 : 14),
                                border: Border.all(
                                  color: upcoming
                                      ? Colors.red
                                      : marked
                                          ? Colors.green
                                          : Colors.grey.shade300,
                                ),
                                boxShadow: [
                                  if (upcoming)
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.22),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      value.toString(),
                                      style: TextStyle(
                                        color: marked || upcoming ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: numberFontSize,
                                      ),
                                    ),
                                  ),

                                  if (marked)
                                    Positioned(
                                      top: compact ? 2 : 4,
                                      right: compact ? 2 : 4,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: compact ? 12 : 16,
                                      ),
                                    ),

                                  if (upcoming)
                                    Positioned(
                                      bottom: compact ? 2 : 4,
                                      right: compact ? 2 : 4,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.16),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          "NEXT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: compact ? 6 : 7,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: compact ? 10 : 20),

          // LEGEND
          Wrap(
            spacing: compact ? 8 : 14,
            runSpacing: compact ? 6 : 14,
            alignment: WrapAlignment.center,
            children: [
              buildLegend(
                color: Colors.green,
                label: "Marked",
                textColor: Colors.black87,
              ),
              buildLegend(
                color: Colors.grey.shade300,
                label: "Unmarked",
                textColor: Colors.black87,
              ),
              if (revealUpcoming)
                buildLegend(
                  color: Colors.red,
                  label: "Upcoming",
                  textColor: Colors.black87,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLegend({
    required Color color,
    required String label,
    Color textColor = Colors.black87,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 12 : 18,
          height: compact ? 12 : 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(compact ? 4 : 6),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: compact ? 11 : 14,
          ),
        ),
      ],
    );
  }
}
