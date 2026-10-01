import '../models/win_type.dart';

class WinValidationEngine {
  // =========================
  // VALIDATE WIN CLAIM
  // =========================

  static bool validateClaim({
    required String claimName,
    required List<List<int?>> ticket,
    required List<int> markedNumbers,
    required List<int> calledNumbers,
  }) {
    final calledSet = calledNumbers.toSet();
    final markedSet = markedNumbers.toSet();

    // Collect all numbers on the ticket per row
    final row0 = ticket.length > 0 ? ticket[0].whereType<int>().toList() : <int>[];
    final row1 = ticket.length > 1 ? ticket[1].whereType<int>().toList() : <int>[];
    final row2 = ticket.length > 2 ? ticket[2].whereType<int>().toList() : <int>[];

    final allTicketNumbers = [...row0, ...row1, ...row2];

    switch (claimName.toLowerCase()) {
      case 'early five':
      case 'earlyfive':
        // Must have at least 5 marked numbers that are on ticket & called
        final validMarks = allTicketNumbers
            .where((n) => markedSet.contains(n) && calledSet.contains(n))
            .length;
        return validMarks >= 5;

      case 'top line':
      case 'topline':
        if (row0.isEmpty) return false;
        return row0.every((n) => markedSet.contains(n) && calledSet.contains(n));

      case 'middle line':
      case 'middleline':
        if (row1.isEmpty) return false;
        return row1.every((n) => markedSet.contains(n) && calledSet.contains(n));

      case 'bottom line':
      case 'bottomline':
        if (row2.isEmpty) return false;
        return row2.every((n) => markedSet.contains(n) && calledSet.contains(n));

      case 'full house':
      case 'fullhouse':
        if (allTicketNumbers.isEmpty) return false;
        return allTicketNumbers.every((n) => markedSet.contains(n) && calledSet.contains(n));

      default:
        return false;
    }
  }
}
