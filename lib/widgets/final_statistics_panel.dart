// import 'package:flutter/material.dart';

// class FinalStatisticsPanel extends StatelessWidget {
//   final int totalRounds;

//   final int totalNumbers;

//   final int totalPredictions;

//   final int successfulPredictions;

//   final int totalClaims;

//   final bool influencerCaught;

//   const FinalStatisticsPanel({
//     super.key,
//     required this.totalRounds,
//     required this.totalNumbers,
//     required this.totalPredictions,
//     required this.successfulPredictions,
//     required this.totalClaims,
//     required this.influencerCaught,
//   });

//   // =========================
//   // ACCURACY
//   // =========================

//   double get accuracy {
//     if (totalPredictions == 0) {
//       return 0;
//     }

//     return successfulPredictions / totalPredictions;
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
//             Color(0xFF111827),
//             Color(0xFF1F2937),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(
//           32,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(
//               0.24,
//             ),
//             blurRadius: 20,
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
//                 width: 62,
//                 height: 62,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(
//                     0.08,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     20,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.bar_chart,
//                   color: Colors.white,
//                   size: 34,
//                 ),
//               ),
//               const SizedBox(
//                 width: 16,
//               ),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Final Statistics",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Text(
//                       "Complete match analytics",
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
//                   color: influencerCaught
//                       ? Colors.green.withOpacity(
//                           0.14,
//                         )
//                       : Colors.red.withOpacity(
//                           0.14,
//                         ),
//                   borderRadius: BorderRadius.circular(
//                     16,
//                   ),
//                 ),
//                 child: Text(
//                   influencerCaught ? "CAUGHT" : "ESCAPED",
//                   style: TextStyle(
//                     color: influencerCaught ? Colors.greenAccent : Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 11,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(
//             height: 30,
//           ),

//           // =====================
//           // STATS GRID
//           // =====================

//           GridView.count(
//             crossAxisCount: 2,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisSpacing: 14,
//             mainAxisSpacing: 14,
//             childAspectRatio: 1.35,
//             children: [
//               buildStatCard(
//                 title: "Rounds",
//                 value: totalRounds.toString(),
//                 icon: Icons.autorenew,
//                 color: Colors.blue,
//               ),
//               buildStatCard(
//                 title: "Numbers",
//                 value: totalNumbers.toString(),
//                 icon: Icons.pin,
//                 color: Colors.green,
//               ),
//               buildStatCard(
//                 title: "Predictions",
//                 value: totalPredictions.toString(),
//                 icon: Icons.psychology,
//                 color: Colors.deepPurple,
//               ),
//               buildStatCard(
//                 title: "Claims",
//                 value: totalClaims.toString(),
//                 icon: Icons.workspace_premium,
//                 color: Colors.orange,
//               ),
//             ],
//           ),

//           const SizedBox(
//             height: 30,
//           ),

//           // =====================
//           // ACCURACY
//           // =====================

//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(
//               22,
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
//                       "${(accuracy * 100).toInt()}%",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
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
//                     value: accuracy,
//                     minHeight: 14,
//                     backgroundColor: Colors.white12,
//                     valueColor: const AlwaysStoppedAnimation(
//                       Colors.greenAccent,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   influencerCaught
//                       ? "Players successfully exposed the influencer before match completion."
//                       : "Influencer successfully manipulated gameplay and avoided suspicion.",
//                   style: TextStyle(
//                     color: Colors.grey.shade300,
//                     height: 1.6,
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
//           24,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: color,
//             size: 32,
//           ),
//           const SizedBox(
//             height: 14,
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.grey.shade300,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
