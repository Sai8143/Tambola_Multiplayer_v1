// import 'package:flutter_test/flutter_test.dart';
// import 'package:tambola_multiplayer/services/ticket_generator.dart';

// void main() {
//   group('TicketGenerator', () {
//     test('generates a 3x9 ticket', () {
//       final ticket = TicketGenerator.generate();
//       expect(ticket.length, 3);
//       for (var row in ticket) {
//         expect(row.length, 9);
//       }
//     });

//     test('each row has exactly 5 numbers', () {
//       final ticket = TicketGenerator.generate();
//       for (var row in ticket) {
//         final count = row.where((c) => c != null).length;
//         expect(count, 5, reason: 'Row must have 5 numbers, got $count');
//       }
//     });

//     test('numbers are in correct column ranges', () {
//       final ticket = TicketGenerator.generate();
//       for (int col = 0; col < 9; col++) {
//         final int start = (col == 0) ? 1 : col * 10;
//         final int end = (col == 8) ? 90 : col * 10 + 9;
//         for (var row in ticket) {
//           final n = row[col];
//           if (n != null) {
//             expect(n >= start && n <= end, true,
//                 reason: 'Number $n is out of range for column $col');
//           }
//         }
//       }
//     });

//     test('no duplicate numbers', () {
//       final ticket = TicketGenerator.generate();
//       final all = ticket.expand((r) => r).whereType<int>().toList();
//       expect(all.length, 15);
//       expect(all.toSet().length, 15, reason: 'Duplicate numbers found');
//     });
//   });
// }
