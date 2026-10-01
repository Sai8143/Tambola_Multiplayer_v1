// import 'package:flutter/material.dart';

// class MeetingResultBanner extends StatefulWidget {
//   final bool correctVote;

//   final String playerName;

//   final bool visible;

//   final VoidCallback? onClose;

//   const MeetingResultBanner({
//     super.key,
//     required this.correctVote,
//     required this.playerName,
//     this.visible = true,
//     this.onClose,
//   });

//   @override
//   State<MeetingResultBanner> createState() => _MeetingResultBannerState();
// }

// class _MeetingResultBannerState extends State<MeetingResultBanner>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late Animation<double> fadeAnimation;

//   late Animation<Offset> slideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         milliseconds: 350,
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

//     slideAnimation = Tween<Offset>(
//       begin: const Offset(
//         0,
//         -0.2,
//       ),
//       end: Offset.zero,
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
//     covariant MeetingResultBanner oldWidget,
//   ) {
//     super.didUpdateWidget(
//       oldWidget,
//     );

//     if (widget.visible && !oldWidget.visible) {
//       controller.forward();
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

//   Color get bannerColor {
//     return widget.correctVote ? Colors.green : Colors.red;
//   }

//   // =========================
//   // TITLE
//   // =========================

//   String get title {
//     return widget.correctVote ? "Influencer Eliminated" : "Wrong Accusation";
//   }

//   // =========================
//   // DESCRIPTION
//   // =========================

//   String get description {
//     return widget.correctVote
//         ? "${widget.playerName} was secretly manipulating fate."
//         : "${widget.playerName} was innocent.";
//   }

//   // =========================
//   // ICON
//   // =========================

//   IconData get icon {
//     return widget.correctVote ? Icons.gpp_good : Icons.dangerous;
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return FadeTransition(
//       opacity: fadeAnimation,
//       child: SlideTransition(
//         position: slideAnimation,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             width: double.infinity,
//             margin: const EdgeInsets.only(
//               top: 18,
//             ),
//             padding: const EdgeInsets.all(
//               22,
//             ),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   bannerColor,
//                   bannerColor.withOpacity(
//                     0.8,
//                   ),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(
//                 26,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: bannerColor.withOpacity(
//                     0.28,
//                   ),
//                   blurRadius: 16,
//                   offset: const Offset(
//                     0,
//                     8,
//                   ),
//                 ),
//               ],
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // =====================
//                 // ICON
//                 // =====================

//                 Container(
//                   width: 64,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(
//                       0.14,
//                     ),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     color: Colors.white,
//                     size: 34,
//                   ),
//                 ),

//                 const SizedBox(
//                   width: 16,
//                 ),

//                 // =====================
//                 // CONTENT
//                 // =====================

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               title,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 6,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(
//                                 0.14,
//                               ),
//                               borderRadius: BorderRadius.circular(
//                                 14,
//                               ),
//                             ),
//                             child: const Text(
//                               "MEETING",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         description,
//                         style: TextStyle(
//                           color: Colors.grey.shade100,
//                           fontSize: 14,
//                           height: 1.5,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             widget.correctVote
//                                 ? Icons.verified
//                                 : Icons.error_outline,
//                             color: Colors.white,
//                             size: 18,
//                           ),
//                           const SizedBox(
//                             width: 6,
//                           ),
//                           Expanded(
//                             child: Text(
//                               widget.correctVote
//                                   ? "Players successfully exposed the hidden influencer."
//                                   : "Players lost trust after eliminating an innocent player.",
//                               style: TextStyle(
//                                 color: Colors.grey.shade100,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // =====================
//                 // CLOSE
//                 // =====================

//                 if (widget.onClose != null)
//                   IconButton(
//                     onPressed: widget.onClose,
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.white,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
