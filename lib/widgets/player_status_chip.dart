// import 'package:flutter/material.dart';

// class PlayerStatusChip extends StatelessWidget {
//   final String label;

//   final Color color;

//   final IconData icon;

//   final bool glowing;

//   final bool outlined;

//   const PlayerStatusChip({
//     super.key,
//     required this.label,
//     required this.color,
//     required this.icon,
//     this.glowing = false,
//     this.outlined = false,
//   });

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return AnimatedContainer(
//       duration: const Duration(
//         milliseconds: 220,
//       ),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 14,
//         vertical: 10,
//       ),
//       decoration: BoxDecoration(
//         color: outlined
//             ? Colors.transparent
//             : color.withOpacity(
//                 0.14,
//               ),
//         borderRadius: BorderRadius.circular(
//           30,
//         ),
//         border: Border.all(
//           color: color.withOpacity(
//             outlined ? 1 : 0.45,
//           ),
//           width: outlined ? 1.5 : 1,
//         ),
//         boxShadow: glowing
//             ? [
//                 BoxShadow(
//                   color: color.withOpacity(
//                     0.24,
//                   ),
//                   blurRadius: 10,
//                   offset: const Offset(
//                     0,
//                     4,
//                   ),
//                 ),
//               ]
//             : [],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // =====================
//           // ICON
//           // =====================

//           Container(
//             width: 22,
//             height: 22,
//             decoration: BoxDecoration(
//               color: color.withOpacity(
//                 0.14,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: color,
//               size: 14,
//             ),
//           ),

//           const SizedBox(
//             width: 8,
//           ),

//           // =====================
//           // LABEL
//           // =====================

//           Text(
//             label.toUpperCase(),
//             style: TextStyle(
//               color: color,
//               fontWeight: FontWeight.bold,
//               fontSize: 11,
//               letterSpacing: 0.8,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
