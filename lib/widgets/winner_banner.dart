// import 'package:flutter/material.dart';

// class WinnerBanner extends StatefulWidget {
//   final bool playersWon;

//   final String title;

//   final String subtitle;

//   final bool visible;

//   const WinnerBanner({
//     super.key,
//     required this.playersWon,
//     required this.title,
//     required this.subtitle,
//     required this.visible,
//   });

//   @override
//   State<WinnerBanner> createState() => _WinnerBannerState();
// }

// class _WinnerBannerState extends State<WinnerBanner>
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
//         milliseconds: 500,
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
//     covariant WinnerBanner oldWidget,
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
//   // EMOJI
//   // =========================

//   String get emoji {
//     return widget.playersWon ? "🏆" : "🕵️";
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
//               34,
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
//               // BADGE
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
//                 child: const Text(
//                   "MATCH COMPLETE",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: 28,
//               ),

//               // ===================
//               // EMOJI
//               // ===================

//               Container(
//                 width: 150,
//                 height: 150,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withOpacity(
//                     0.12,
//                   ),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(
//                       0.16,
//                     ),
//                     width: 2,
//                   ),
//                 ),
//                 child: Text(
//                   emoji,
//                   style: const TextStyle(
//                     fontSize: 80,
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: 30,
//               ),

//               // ===================
//               // TITLE
//               // ===================

//               Text(
//                 widget.title,
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
//                 widget.subtitle,
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
//               // FOOTER
//               // ===================

//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(
//                   18,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(
//                     0.16,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     24,
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.emoji_events,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(
//                       width: 12,
//                     ),
//                     Expanded(
//                       child: Text(
//                         widget.playersWon
//                             ? "Players successfully exposed the hidden influencer."
//                             : "Influencers manipulated the game and escaped detection.",
//                         style: TextStyle(
//                           color: Colors.grey.shade100,
//                           height: 1.5,
//                         ),
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
// }
