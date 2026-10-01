// import 'package:flutter/material.dart';

// class ScoreBoard extends StatelessWidget {
//   final int playerScore;

//   final int influencerScore;

//   final int round;

//   final int calledNumbers;

//   const ScoreBoard({
//     super.key,
//     required this.playerScore,
//     required this.influencerScore,
//     required this.round,
//     required this.calledNumbers,
//   });

//   // =========================
//   // TOTAL
//   // =========================

//   int get totalScore {
//     return playerScore + influencerScore;
//   }

//   // =========================
//   // PLAYER PERCENT
//   // =========================

//   double get playerPercent {
//     if (totalScore == 0) {
//       return 0.5;
//     }

//     return playerScore / totalScore;
//   }

//   // =========================
//   // INFLUENCER PERCENT
//   // =========================

//   double get influencerPercent {
//     if (totalScore == 0) {
//       return 0.5;
//     }

//     return influencerScore / totalScore;
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
//         22,
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
//                 width: 56,
//                 height: 56,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(
//                     0.08,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     18,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.leaderboard,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//               const SizedBox(
//                 width: 14,
//               ),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Live Score Board",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Text(
//                       "Real-time round statistics",
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
//                   color: Colors.white.withOpacity(
//                     0.08,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     16,
//                   ),
//                 ),
//                 child: Text(
//                   "R$round",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(
//             height: 28,
//           ),

//           // =====================
//           // SCORE CARDS
//           // =====================

//           Row(
//             children: [
//               Expanded(
//                 child: buildScoreCard(
//                   title: "Players",
//                   score: playerScore,
//                   icon: Icons.shield,
//                   color: Colors.green,
//                   percentage: playerPercent,
//                 ),
//               ),
//               const SizedBox(
//                 width: 16,
//               ),
//               Expanded(
//                 child: buildScoreCard(
//                   title: "Influencers",
//                   score: influencerScore,
//                   icon: Icons.visibility,
//                   color: Colors.red,
//                   percentage: influencerPercent,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(
//             height: 26,
//           ),

//           // =====================
//           // MATCH PROGRESS
//           // =====================

//           Container(
//             padding: const EdgeInsets.all(
//               18,
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
//                       Icons.timeline,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Expanded(
//                       child: Text(
//                         "Game Progress",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "$calledNumbers / 90",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
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
//                     value: calledNumbers / 90,
//                     minHeight: 12,
//                     backgroundColor: Colors.white12,
//                     valueColor: const AlwaysStoppedAnimation(
//                       Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 14,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         calledNumbers >= 80
//                             ? "Final phase of the match."
//                             : calledNumbers >= 40
//                                 ? "Mid-game influence battle ongoing."
//                                 : "Early game in progress.",
//                         style: TextStyle(
//                           color: Colors.grey.shade300,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =========================
//   // SCORE CARD
//   // =========================

//   Widget buildScoreCard({
//     required String title,
//     required int score,
//     required IconData icon,
//     required Color color,
//     required double percentage,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(
//         20,
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
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: color.withOpacity(
//                 0.14,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: color,
//               size: 32,
//             ),
//           ),
//           const SizedBox(
//             height: 18,
//           ),
//           Text(
//             score.toString(),
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 34,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.grey.shade300,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(
//             height: 18,
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(
//               10,
//             ),
//             child: LinearProgressIndicator(
//               value: percentage,
//               minHeight: 10,
//               backgroundColor: Colors.white12,
//               valueColor: AlwaysStoppedAnimation(
//                 color,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Text(
//             "${(percentage * 100).toInt()}%",
//             style: TextStyle(
//               color: color,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
