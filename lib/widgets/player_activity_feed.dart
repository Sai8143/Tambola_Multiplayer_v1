// import 'package:flutter/material.dart';

// class PlayerActivityFeed extends StatelessWidget {
//   final List<Map<String, dynamic>> activities;

//   const PlayerActivityFeed({
//     super.key,
//     required this.activities,
//   });

//   // =========================
//   // ICON
//   // =========================

//   IconData getIcon(
//     String type,
//   ) {
//     switch (type) {
//       case "prediction":
//         return Icons.psychology;

//       case "win":
//         return Icons.emoji_events;

//       case "warning":
//         return Icons.warning;

//       case "elimination":
//         return Icons.gpp_bad;

//       default:
//         return Icons.info;
//     }
//   }

//   // =========================
//   // COLOR
//   // =========================

//   Color getColor(
//     String type,
//   ) {
//     switch (type) {
//       case "prediction":
//         return Colors.deepPurple;

//       case "win":
//         return Colors.green;

//       case "warning":
//         return Colors.orange;

//       case "elimination":
//         return Colors.red;

//       default:
//         return Colors.indigo;
//     }
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
//                   Icons.dynamic_feed,
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
//                       "Activity Feed",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Text(
//                       "Recent player activities",
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
//                     Icons.dynamic_feed,
//                     size: 44,
//                     color: Colors.grey.shade500,
//                   ),
//                   const SizedBox(
//                     height: 14,
//                   ),
//                   Text(
//                     "No activities yet",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           // =====================
//           // ACTIVITY LIST
//           // =====================

//           if (activities.isNotEmpty)
//             ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: activities.length,
//               separatorBuilder: (
//                 _,
//                 __,
//               ) =>
//                   const SizedBox(
//                 height: 16,
//               ),
//               itemBuilder: (
//                 context,
//                 index,
//               ) {
//                 final activity = activities[index];

//                 final String type = activity['type'].toString();

//                 final color = getColor(type);

//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // =================
//                     // TIMELINE
//                     // =================

//                     Column(
//                       children: [
//                         Container(
//                           width: 58,
//                           height: 58,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 color,
//                                 color.withOpacity(
//                                   0.72,
//                                 ),
//                               ],
//                             ),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             getIcon(
//                               type,
//                             ),
//                             color: Colors.white,
//                             size: 28,
//                           ),
//                         ),
//                         if (index != activities.length - 1)
//                           Container(
//                             width: 3,
//                             height: 56,
//                             color: color.withOpacity(
//                               0.18,
//                             ),
//                           ),
//                       ],
//                     ),

//                     const SizedBox(
//                       width: 18,
//                     ),

//                     // =================
//                     // CONTENT
//                     // =================

//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.all(
//                           18,
//                         ),
//                         decoration: BoxDecoration(
//                           color: color.withOpacity(
//                             0.08,
//                           ),
//                           borderRadius: BorderRadius.circular(
//                             24,
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               activity['title'].toString(),
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             Text(
//                               activity['description'].toString(),
//                               style: TextStyle(
//                                 color: Colors.grey.shade700,
//                                 height: 1.6,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 14,
//                             ),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.access_time,
//                                   color: color,
//                                   size: 18,
//                                 ),
//                                 const SizedBox(
//                                   width: 6,
//                                 ),
//                                 Text(
//                                   activity['time'].toString(),
//                                   style: TextStyle(
//                                     color: color,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
