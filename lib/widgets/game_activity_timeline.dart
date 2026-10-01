// import 'package:flutter/material.dart';

// class GameActivityTimeline extends StatelessWidget {
//   final List<String> activities;

//   const GameActivityTimeline({
//     super.key,
//     required this.activities,
//   });

//   // =========================
//   // ICON SELECTOR
//   // =========================

//   IconData getIcon(
//     String activity,
//   ) {
//     final value = activity.toLowerCase();

//     if (value.contains(
//       'round',
//     )) {
//       return Icons.autorenew;
//     }

//     if (value.contains(
//       'winner',
//     )) {
//       return Icons.emoji_events;
//     }

//     if (value.contains(
//       'prediction',
//     )) {
//       return Icons.psychology;
//     }

//     if (value.contains(
//       'claim',
//     )) {
//       return Icons.workspace_premium;
//     }

//     if (value.contains(
//       'influence',
//     )) {
//       return Icons.visibility;
//     }

//     return Icons.bolt;
//   }

//   // =========================
//   // COLOR SELECTOR
//   // =========================

//   Color getColor(
//     String activity,
//   ) {
//     final value = activity.toLowerCase();

//     if (value.contains(
//       'winner',
//     )) {
//       return Colors.green;
//     }

//     if (value.contains(
//       'influence',
//     )) {
//       return Colors.red;
//     }

//     if (value.contains(
//       'prediction',
//     )) {
//       return Colors.deepPurple;
//     }

//     if (value.contains(
//       'claim',
//     )) {
//       return Colors.orange;
//     }

//     return Colors.indigo;
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
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(
//           30,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(
//               0.06,
//             ),
//             blurRadius: 14,
//             offset: const Offset(
//               0,
//               6,
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
//                 width: 58,
//                 height: 58,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Colors.indigo,
//                       Colors.deepPurple,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     18,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.history,
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
//                       "Activity Timeline",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Text(
//                       "Recent match events",
//                       style: TextStyle(
//                         color: Colors.grey,
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
//                   color: Colors.indigo.withOpacity(
//                     0.08,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     16,
//                   ),
//                 ),
//                 child: Text(
//                   "${activities.length}",
//                   style: const TextStyle(
//                     color: Colors.indigo,
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
//           // EMPTY STATE
//           // =====================

//           if (activities.isEmpty)
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(
//                 vertical: 36,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(
//                   24,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     Icons.timeline,
//                     size: 44,
//                     color: Colors.grey.shade500,
//                   ),
//                   const SizedBox(
//                     height: 14,
//                   ),
//                   Text(
//                     "No activities recorded",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           // =====================
//           // TIMELINE
//           // =====================

//           if (activities.isNotEmpty)
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: activities.length,
//               itemBuilder: (
//                 context,
//                 index,
//               ) {
//                 final activity = activities[index];

//                 final color = getColor(
//                   activity,
//                 );

//                 final icon = getIcon(
//                   activity,
//                 );

//                 final bool latest = index == 0;

//                 return IntrinsicHeight(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // =================
//                       // TIMELINE LINE
//                       // =================

//                       Column(
//                         children: [
//                           Container(
//                             width: 46,
//                             height: 46,
//                             decoration: BoxDecoration(
//                               color: color,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               icon,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                           if (index != activities.length - 1)
//                             Expanded(
//                               child: Container(
//                                 width: 3,
//                                 margin: const EdgeInsets.symmetric(
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(
//                                     10,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),

//                       const SizedBox(
//                         width: 16,
//                       ),

//                       // =================
//                       // CONTENT
//                       // =================

//                       Expanded(
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                             bottom: 18,
//                           ),
//                           padding: const EdgeInsets.all(
//                             18,
//                           ),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 color.withOpacity(
//                                   0.08,
//                                 ),
//                                 color.withOpacity(
//                                   0.03,
//                                 ),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(
//                               24,
//                             ),
//                             border: Border.all(
//                               color: color.withOpacity(
//                                 0.14,
//                               ),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       latest ? "LATEST EVENT" : "EVENT",
//                                       style: TextStyle(
//                                         color: color,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                         letterSpacing: 1,
//                                       ),
//                                     ),
//                                   ),
//                                   if (latest)
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 10,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: color,
//                                         borderRadius: BorderRadius.circular(
//                                           10,
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         "LIVE",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 activity,
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   height: 1.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
