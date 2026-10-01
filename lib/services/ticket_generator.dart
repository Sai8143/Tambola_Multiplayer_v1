import 'dart:math';

/// Generates a standard Tambola / Housie ticket.
///
/// Rules:
///   • 3 rows × 9 columns
///   • Each row has exactly 5 numbers and 4 blanks
///   • Column ranges: col 0 → 1–9, col 1 → 10–19, …, col 8 → 80–90
///   • Each column has 1–3 numbers (at least 1, at most 3)
///   • Numbers within a column are sorted top-to-bottom
class TicketGenerator {
  static List<List<int?>> generate() {
    final rand = Random();
    while (true) {
      // Step 1: Decide which rows each column gets a number in.
      List<Set<int>> colRows = List.generate(9, (_) => <int>{});
      List<int> rowCount = [0, 0, 0];

      // At least 1 number per column
      for (int col = 0; col < 9; col++) {
        int r = rand.nextInt(3);
        colRows[col].add(r);
        rowCount[r]++;
      }

      // Need 15 total → 9 already placed → add 6 more
      int remaining = 6;
      int attempts = 0;
      while (remaining > 0 && attempts < 500) {
        attempts++;
        int col = rand.nextInt(9);
        if (colRows[col].length >= 3) continue;

        List<int> needy = [0, 1, 2].where((r) => rowCount[r] < 5).toList();
        if (needy.isEmpty) break;

        List<int> candidates =
            needy.where((r) => !colRows[col].contains(r)).toList();
        if (candidates.isEmpty) continue;

        int r = candidates[rand.nextInt(candidates.length)];
        colRows[col].add(r);
        rowCount[r]++;
        remaining--;
      }

      if (rowCount[0] != 5 || rowCount[1] != 5 || rowCount[2] != 5) continue;

      // Step 2: Assign numbers
      List<List<int?>> ticket =
          List.generate(3, (_) => List.filled(9, null));
      bool ok = true;

      for (int col = 0; col < 9; col++) {
        int start = (col == 0) ? 1 : col * 10;
        int end = (col == 8) ? 90 : col * 10 + 9;
        int count = colRows[col].length;
        int range = end - start + 1;

        if (count > range) {
          ok = false;
          break;
        }

        List<int> pool =
            List.generate(range, (i) => start + i)..shuffle(rand);
        List<int> chosen = pool.take(count).toList()..sort();
        List<int> sortedRows = colRows[col].toList()..sort();

        for (int i = 0; i < count; i++) {
          ticket[sortedRows[i]][col] = chosen[i];
        }
      }

      if (!ok) continue;
      return ticket;
    }
  }
}
