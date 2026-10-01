// import 'package:flutter/material.dart';

// class RoundSummaryCard extends StatelessWidget {
//   final int round;

//   final int totalNumbers;

//   final int markedNumbers;

//   final int predictionsMade;

//   final int successfulPredictions;

//   final bool influencerDetected;

//   const RoundSummaryCard({
//     super.key,
//     required this.round,
//     required this.totalNumbers,
//     required this.markedNumbers,
//     required this.predictionsMade,
//     required this.successfulPredictions,
//     required this.influencerDetected,
//   });

//   // =========================
//   // SUCCESS RATE
//   // =========================

//   double get successRate {
//     if (predictionsMade == 0) {
//       return 0;
//     }

//     return successfulPredictions / predictionsMade;
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(
//         top: 22,
//       ),
//       padding: const EdgeInsets.all(
//         24,
//       ),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color(0xFF1E1B4B),
//             Color(0xFF312E81),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(
//           30,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(
//               0.22,
//             ),
//             blurRadius: 18,
//             offset: const Offset(
//               0,
//               10,
//             ),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // =====================
//           // HEADER
//           // =====================

//           Row(
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(
//                     0.08,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     18,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.analytics,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),
//               const SizedBox(
//                 width: 16,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Round $round Summary",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     const Text(
//                       "Performance overview",
//                       style: TextStyle(
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: influencerDetected
//                       ? Colors.red.withOpacity(
//                           0.14,
//                         )
//                       : Colors.green.withOpacity(
//                           0.14,
//                         ),
//                   borderRadius: BorderRadius.circular(
//                     16,
//                   ),
//                 ),
//                 child: Text(
//                   influencerDetected ? "DETECTED" : "HIDDEN",
//                   style: TextStyle(
//                     color: influencerDetected ? Colors.red : Colors.greenAccent,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 11,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(
//             height: 28,
//           ),

//           // =====================
//           // STATS GRID
//           // =====================

//           GridView.count(
//             crossAxisCount: 2,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             mainAxisSpacing: 14,
//             crossAxisSpacing: 14,
//             childAspectRatio: 1.4,
//             children: [
//               buildStatCard(
//                 title: "Numbers Called",
//                 value: totalNumbers.toString(),
//                 icon: Icons.pin,
//                 color: Colors.blue,
//               ),
//               buildStatCard(
//                 title: "Marked Numbers",
//                 value: markedNumbers.toString(),
//                 icon: Icons.check_circle,
//                 color: Colors.green,
//               ),
//               buildStatCard(
//                 title: "Predictions",
//                 value: predictionsMade.toString(),
//                 icon: Icons.psychology,
//                 color: Colors.deepPurple,
//               ),
//               buildStatCard(
//                 title: "Successful",
//                 value: successfulPredictions.toString(),
//                 icon: Icons.workspace_premium,
//                 color: Colors.orange,
//               ),
//             ],
//           ),

//           const SizedBox(
//             height: 28,
//           ),

//           // =====================
//           // SUCCESS RATE
//           // =====================

//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(
//               20,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(
//                 0.06,
//               ),
//               borderRadius: BorderRadius.circular(
//                 24,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.trending_up,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Expanded(
//                       child: Text(
//                         "Prediction Accuracy",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "${(successRate * 100).toInt()}%",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 18,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(
//                     12,
//                   ),
//                   child: LinearProgressIndicator(
//                     value: successRate,
//                     minHeight: 14,
//                     backgroundColor: Colors.white12,
//                     valueColor: const AlwaysStoppedAnimation(
//                       Colors.greenAccent,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 14,
//                 ),
//                 Text(
//                   influencerDetected
//                       ? "Players became suspicious during this round."
//                       : "Influencer activity remained undetected.",
//                   style: TextStyle(
//                     color: Colors.grey.shade300,
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =========================
//   // STAT CARD
//   // =========================

//   Widget buildStatCard({
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(
//         18,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(
//           0.06,
//         ),
//         borderRadius: BorderRadius.circular(
//           22,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: color,
//             size: 30,
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.grey.shade300,
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
