// import 'package:flutter/material.dart';

// import '../models/win_type.dart';

// class WinDialog extends StatelessWidget {
//   final WinType type;

//   final bool influencersWon;

//   final VoidCallback? onContinue;

//   final VoidCallback? onExit;

//   const WinDialog({
//     super.key,
//     required this.type,
//     this.influencersWon = false,
//     this.onContinue,
//     this.onExit,
//   });

//   // =========================
//   // SHOW
//   // =========================

//   static Future<void> show(
//     BuildContext context,
//     WinType type, {
//     bool influencersWon = false,
//     VoidCallback? onContinue,
//     VoidCallback? onExit,
//   }) {
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => WinDialog(
//         type: type,
//         influencersWon: influencersWon,
//         onContinue: onContinue,
//         onExit: onExit,
//       ),
//     );
//   }

//   // =========================
//   // COLOR
//   // =========================

//   Color get primaryColor {
//     if (influencersWon) {
//       return Colors.red;
//     }

//     switch (type.name.toLowerCase()) {
//       case 'fullhouse':
//         return Colors.green;

//       case 'topline':
//         return Colors.orange;

//       case 'middleline':
//         return Colors.deepPurple;

//       case 'bottomline':
//         return Colors.blue;

//       default:
//         return Colors.teal;
//     }
//   }

//   // =========================
//   // EMOJI
//   // =========================

//   String get emoji {
//     if (influencersWon) {
//       return "🕵️";
//     }

//     switch (type.name.toLowerCase()) {
//       case 'fullhouse':
//         return "🏆";

//       case 'topline':
//         return "🔥";

//       case 'middleline':
//         return "⚡";

//       case 'bottomline':
//         return "🎯";

//       default:
//         return "🎉";
//     }
//   }

//   // =========================
//   // TITLE
//   // =========================

//   String get title {
//     if (influencersWon) {
//       return "Influencers Win";
//     }

//     return type.label;
//   }

//   // =========================
//   // DESCRIPTION
//   // =========================

//   String get description {
//     if (influencersWon) {
//       return "The hidden influencers successfully manipulated fate and dominated the entire system.";
//     }

//     return type.description;
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.symmetric(
//         horizontal: 24,
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(
//           28,
//         ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               primaryColor,
//               primaryColor.withOpacity(
//                 0.75,
//               ),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(
//             32,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: primaryColor.withOpacity(
//                 0.28,
//               ),
//               blurRadius: 24,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // =====================
//             // EMOJI
//             // =====================

//             AnimatedScale(
//               duration: const Duration(
//                 milliseconds: 350,
//               ),
//               scale: 1,
//               child: Text(
//                 emoji,
//                 style: const TextStyle(
//                   fontSize: 84,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 22),

//             // =====================
//             // TITLE
//             // =====================

//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 14),

//             // =====================
//             // DESCRIPTION
//             // =====================

//             Text(
//               description,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey.shade100,
//                 fontSize: 15,
//                 height: 1.6,
//               ),
//             ),

//             const SizedBox(height: 28),

//             // =====================
//             // STATS CARD
//             // =====================

//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(
//                 20,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(
//                   0.10,
//                 ),
//                 borderRadius: BorderRadius.circular(
//                   24,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   buildStat(
//                     icon: Icons.emoji_events,
//                     label: "Achievement",
//                     value: title,
//                   ),
//                   const SizedBox(height: 16),
//                   buildStat(
//                     icon: Icons.casino,
//                     label: "Mode",
//                     value: "Hidden Influence",
//                   ),
//                   const SizedBox(height: 16),
//                   buildStat(
//                     icon: Icons.confirmation_num,
//                     label: "Status",
//                     value:
//                         influencersWon ? "Chaos Dominated" : "Victory Achieved",
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 32),

//             // =====================
//             // BUTTONS
//             // =====================

//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: onContinue ??
//                         () {
//                           Navigator.pop(
//                             context,
//                           );
//                         },
//                     icon: const Icon(
//                       Icons.play_arrow,
//                     ),
//                     label: const Text(
//                       "Continue",
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: primaryColor,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: onExit ??
//                         () {
//                           Navigator.pop(
//                             context,
//                           );
//                         },
//                     icon: const Icon(
//                       Icons.home,
//                     ),
//                     label: const Text(
//                       "Exit",
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black.withOpacity(
//                         0.18,
//                       ),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // =========================
//   // STAT
//   // =========================

//   Widget buildStat({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 42,
//           height: 42,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(
//               0.12,
//             ),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: Colors.white,
//             size: 22,
//           ),
//         ),
//         const SizedBox(width: 14),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: Colors.grey.shade300,
//                   fontSize: 12,
//                 ),
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
