// import 'package:flutter/material.dart';

// class EliminationAlertBanner extends StatefulWidget {
//   final bool visible;

//   final String playerName;

//   final String reason;

//   const EliminationAlertBanner({
//     super.key,
//     required this.visible,
//     required this.playerName,
//     required this.reason,
//   });

//   @override
//   State<EliminationAlertBanner> createState() => _EliminationAlertBannerState();
// }

// class _EliminationAlertBannerState extends State<EliminationAlertBanner>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late Animation<double> fadeAnimation;

//   late Animation<double> slideAnimation;

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

//     slideAnimation = Tween<double>(
//       begin: -40,
//       end: 0,
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
//     covariant EliminationAlertBanner oldWidget,
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

//     return AnimatedBuilder(
//       animation: controller,
//       builder: (
//         context,
//         child,
//       ) {
//         return Opacity(
//           opacity: fadeAnimation.value,
//           child: Transform.translate(
//             offset: Offset(
//               0,
//               slideAnimation.value,
//             ),
//             child: child,
//           ),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(
//           top: 22,
//         ),
//         padding: const EdgeInsets.all(
//           24,
//         ),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Colors.red,
//               Colors.deepOrange,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(
//             30,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.withOpacity(
//                 0.24,
//               ),
//               blurRadius: 18,
//               offset: const Offset(
//                 0,
//                 10,
//               ),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ===================
//             // ICON
//             // ===================

//             Container(
//               width: 74,
//               height: 74,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(
//                   0.14,
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.gpp_bad,
//                 color: Colors.white,
//                 size: 40,
//               ),
//             ),

//             const SizedBox(
//               width: 18,
//             ),

//             // ===================
//             // CONTENT
//             // ===================

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ===============
//                   // TITLE
//                   // ===============

//                   const Text(
//                     "PLAYER ELIMINATED",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                       letterSpacing: 1.4,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),

//                   // ===============
//                   // PLAYER NAME
//                   // ===============

//                   Text(
//                     widget.playerName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),

//                   // ===============
//                   // REASON
//                   // ===============

//                   Text(
//                     widget.reason,
//                     style: TextStyle(
//                       color: Colors.grey.shade100,
//                       fontSize: 15,
//                       height: 1.5,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 18,
//                   ),

//                   // ===============
//                   // STATUS CHIP
//                   // ===============

//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(
//                         0.14,
//                       ),
//                       borderRadius: BorderRadius.circular(
//                         16,
//                       ),
//                     ),
//                     child: const Text(
//                       "REMOVED FROM MATCH",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 11,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
