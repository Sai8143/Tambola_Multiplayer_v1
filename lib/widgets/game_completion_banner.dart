// import 'package:flutter/material.dart';

// class GameCompletionBanner extends StatefulWidget {
//   final bool visible;

//   final bool playersWon;

//   final String winnerText;

//   final int totalRounds;

//   final int totalNumbers;

//   const GameCompletionBanner({
//     super.key,
//     required this.visible,
//     required this.playersWon,
//     required this.winnerText,
//     required this.totalRounds,
//     required this.totalNumbers,
//   });

//   @override
//   State<GameCompletionBanner> createState() => _GameCompletionBannerState();
// }

// class _GameCompletionBannerState extends State<GameCompletionBanner>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late Animation<double> scaleAnimation;

//   late Animation<double> fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         milliseconds: 550,
//       ),
//     );

//     scaleAnimation = Tween<double>(
//       begin: 0.85,
//       end: 1,
//     ).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: Curves.easeOutBack,
//       ),
//     );

//     fadeAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: Curves.easeOut,
//       ),
//     );

//     if (widget.visible) {
//       controller.forward();
//     }
//   }

//   @override
//   void didUpdateWidget(
//     covariant GameCompletionBanner oldWidget,
//   ) {
//     super.didUpdateWidget(
//       oldWidget,
//     );

//     if (widget.visible && !oldWidget.visible) {
//       controller.forward(
//         from: 0,
//       );
//     }

//     if (!widget.visible && oldWidget.visible) {
//       controller.reverse();
//     }
//   }

//   @override
//   void dispose() {
//     controller.dispose();

//     super.dispose();
//   }

//   // =========================
//   // COLORS
//   // =========================

//   List<Color> get colors {
//     if (widget.playersWon) {
//       return [
//         Colors.green,
//         Colors.teal,
//       ];
//     }

//     return [
//       Colors.red,
//       Colors.deepPurple,
//     ];
//   }

//   // =========================
//   // ICON
//   // =========================

//   IconData get icon {
//     return widget.playersWon ? Icons.emoji_events : Icons.visibility;
//   }

//   // =========================
//   // STATUS
//   // =========================

//   String get status {
//     return widget.playersWon ? "PLAYERS WON" : "INFLUENCER WON";
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     if (!widget.visible) {
//       return const SizedBox();
//     }

//     return FadeTransition(
//       opacity: fadeAnimation,
//       child: ScaleTransition(
//         scale: scaleAnimation,
//         child: Container(
//           width: double.infinity,
//           margin: const EdgeInsets.only(
//             top: 22,
//           ),
//           padding: const EdgeInsets.all(
//             30,
//           ),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: colors,
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(
//               36,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: colors.first.withOpacity(
//                   0.26,
//                 ),
//                 blurRadius: 22,
//                 offset: const Offset(
//                   0,
//                   10,
//                 ),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               // ===================
//               // STATUS CHIP
//               // ===================

//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(
//                     0.14,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     18,
//                   ),
//                 ),
//                 child: Text(
//                   status,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                     fontSize: 11,
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: 28,
//               ),

//               // ===================
//               // ICON
//               // ===================

//               Container(
//                 width: 160,
//                 height: 160,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withOpacity(
//                     0.14,
//                   ),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: Colors.white,
//                   size: 82,
//                 ),
//               ),

//               const SizedBox(
//                 height: 32,
//               ),

//               // ===================
//               // TITLE
//               // ===================

//               Text(
//                 widget.winnerText,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(
//                 height: 14,
//               ),

//               // ===================
//               // SUBTITLE
//               // ===================

//               Text(
//                 "The match has officially concluded after ${widget.totalRounds} rounds and ${widget.totalNumbers} generated numbers.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.grey.shade100,
//                   fontSize: 16,
//                   height: 1.6,
//                 ),
//               ),

//               const SizedBox(
//                 height: 30,
//               ),

//               // ===================
//               // MATCH SUMMARY
//               // ===================

//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(
//                   20,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(
//                     0.14,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     24,
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: buildInfoColumn(
//                         title: "Rounds",
//                         value: widget.totalRounds.toString(),
//                       ),
//                     ),
//                     Container(
//                       width: 1,
//                       height: 54,
//                       color: Colors.white24,
//                     ),
//                     Expanded(
//                       child: buildInfoColumn(
//                         title: "Numbers",
//                         value: widget.totalNumbers.toString(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // =========================
//   // INFO COLUMN
//   // =========================

//   Widget buildInfoColumn({
//     required String title,
//     required String value,
//   }) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(
//           height: 6,
//         ),
//         Text(
//           title,
//           style: TextStyle(
//             color: Colors.grey.shade200,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
