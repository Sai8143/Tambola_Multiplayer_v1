// import 'package:flutter/material.dart';

// class RoundTransitionBanner extends StatefulWidget {
//   final int round;

//   final String title;

//   final String subtitle;

//   final bool visible;

//   const RoundTransitionBanner({
//     super.key,
//     required this.round,
//     required this.title,
//     required this.subtitle,
//     required this.visible,
//   });

//   @override
//   State<RoundTransitionBanner> createState() => _RoundTransitionBannerState();
// }

// class _RoundTransitionBannerState extends State<RoundTransitionBanner>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late Animation<double> fadeAnimation;

//   late Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         milliseconds: 450,
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

//     scaleAnimation = Tween<double>(
//       begin: 0.9,
//       end: 1,
//     ).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: Curves.easeOutBack,
//       ),
//     );

//     if (widget.visible) {
//       controller.forward();
//     }
//   }

//   @override
//   void didUpdateWidget(
//     covariant RoundTransitionBanner oldWidget,
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
//             28,
//           ),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [
//                 Colors.deepPurple,
//                 Colors.indigo,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(
//               32,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.deepPurple.withOpacity(
//                   0.26,
//                 ),
//                 blurRadius: 20,
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
//               // ROUND BADGE
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
//                   "ROUND ${widget.round}",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: 24,
//               ),

//               // ===================
//               // ICON
//               // ===================

//               Container(
//                 width: 120,
//                 height: 120,
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
//                 child: const Icon(
//                   Icons.autorenew,
//                   color: Colors.white,
//                   size: 60,
//                 ),
//               ),

//               const SizedBox(
//                 height: 28,
//               ),

//               // ===================
//               // TITLE
//               // ===================

//               Text(
//                 widget.title,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 32,
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
//                   color: Colors.grey.shade200,
//                   fontSize: 16,
//                   height: 1.6,
//                 ),
//               ),

//               const SizedBox(
//                 height: 26,
//               ),

//               // ===================
//               // PROGRESS
//               // ===================

//               ClipRRect(
//                 borderRadius: BorderRadius.circular(
//                   12,
//                 ),
//                 child: const LinearProgressIndicator(
//                   value: 1,
//                   minHeight: 10,
//                   backgroundColor: Colors.white12,
//                   valueColor: AlwaysStoppedAnimation(
//                     Colors.white,
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: 12,
//               ),

//               Text(
//                 "Preparing next sequence...",
//                 style: TextStyle(
//                   color: Colors.grey.shade200,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
