// import 'package:flutter/material.dart';

// class PlayerTurnBanner extends StatefulWidget {
//   final String playerName;

//   final int turnNumber;

//   final bool active;

//   final bool influencer;

//   const PlayerTurnBanner({
//     super.key,
//     required this.playerName,
//     required this.turnNumber,
//     required this.active,
//     required this.influencer,
//   });

//   @override
//   State<PlayerTurnBanner> createState() => _PlayerTurnBannerState();
// }

// class _PlayerTurnBannerState extends State<PlayerTurnBanner>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late Animation<double> pulseAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         milliseconds: 1000,
//       ),
//     );

//     pulseAnimation = Tween<double>(
//       begin: 0.96,
//       end: 1.02,
//     ).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: Curves.easeInOut,
//       ),
//     );

//     if (widget.active) {
//       controller.repeat(
//         reverse: true,
//       );
//     }
//   }

//   @override
//   void didUpdateWidget(
//     covariant PlayerTurnBanner oldWidget,
//   ) {
//     super.didUpdateWidget(
//       oldWidget,
//     );

//     if (widget.active && !oldWidget.active) {
//       controller.repeat(
//         reverse: true,
//       );
//     }

//     if (!widget.active && oldWidget.active) {
//       controller.stop();

//       controller.reset();
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
//     if (widget.influencer) {
//       return [
//         Colors.red,
//         Colors.deepPurple,
//       ];
//     }

//     return [
//       Colors.green,
//       Colors.teal,
//     ];
//   }

//   // =========================
//   // STATUS
//   // =========================

//   String get status {
//     return widget.active ? "ACTIVE TURN" : "WAITING";
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return ScaleTransition(
//       scale: pulseAnimation,
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(
//           top: 22,
//         ),
//         padding: const EdgeInsets.all(
//           24,
//         ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: colors,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(
//             30,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: colors.first.withOpacity(
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
//           children: [
//             // ===================
//             // AVATAR
//             // ===================

//             Container(
//               width: 82,
//               height: 82,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(
//                   0.14,
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Text(
//                   widget.playerName
//                       .substring(
//                         0,
//                         1,
//                       )
//                       .toUpperCase(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
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
//                   // TURN CHIP
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
//                     child: Text(
//                       "TURN ${widget.turnNumber}",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 11,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 14,
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
//                     height: 8,
//                   ),

//                   // ===============
//                   // STATUS
//                   // ===============

//                   Text(
//                     status,
//                     style: TextStyle(
//                       color: Colors.grey.shade100,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // ===================
//             // ROLE ICON
//             // ===================

//             Container(
//               width: 72,
//               height: 72,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(
//                   0.14,
//                 ),
//                 borderRadius: BorderRadius.circular(
//                   22,
//                 ),
//               ),
//               child: Icon(
//                 widget.influencer ? Icons.visibility : Icons.shield,
//                 color: Colors.white,
//                 size: 38,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
