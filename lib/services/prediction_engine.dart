class PredictionEngine {
  // =========================
  // EVALUATE PREDICTION
  // =========================

  static bool evaluatePrediction({
    required String prediction,
    required int? currentNumber,
    required List<int> markedNumbers,
    required List<List<int?>> ticket,
  }) {
    if (prediction.trim().isEmpty) {
      return false;
    }

    if (currentNumber == null) {
      return false;
    }

    final value = prediction.trim().toLowerCase();

    // =====================
    // EVEN
    // =====================

    if (value == 'even') {
      return currentNumber % 2 == 0;
    }

    // =====================
    // ODD
    // =====================

    if (value == 'odd') {
      return currentNumber % 2 != 0;
    }

    // =====================
    // HIGH
    // =====================

    if (value == 'high') {
      return currentNumber >= 46;
    }

    // =====================
    // LOW
    // =====================

    if (value == 'low') {
      return currentNumber <= 45;
    }

    // =====================
    // TOP LINE
    // =====================

    if (value == 'top line') {
      return rowCompleted(
        ticket,
        markedNumbers,
        0,
      );
    }

    // =====================
    // MIDDLE LINE
    // =====================

    if (value == 'middle line') {
      return rowCompleted(
        ticket,
        markedNumbers,
        1,
      );
    }

    // =====================
    // BOTTOM LINE
    // =====================

    if (value == 'bottom line') {
      return rowCompleted(
        ticket,
        markedNumbers,
        2,
      );
    }

    return false;
  }

  // =========================
  // UPDATE SCORE
  // =========================

  static int updateScore({
    required int currentScore,
    required bool success,
  }) {
    if (success) {
      return currentScore + 10;
    }

    int updated = currentScore - 5;

    if (updated < 0) {
      updated = 0;
    }

    return updated;
  }

  // =========================
  // ROW COMPLETE
  // =========================

  static bool rowCompleted(
    List<List<int?>> ticket,
    List<int> marked,
    int row,
  ) {
    final rowNumbers = ticket[row].whereType<int>().toList();

    return rowNumbers.every(
      marked.contains,
    );
  }

  // =========================
  // FULL HOUSE
  // =========================

  static bool fullHouse(
    List<List<int?>> ticket,
    List<int> marked,
  ) {
    final numbers = ticket.expand((e) => e).whereType<int>().toList();

    return numbers.every(
      marked.contains,
    );
  }

  // =========================
  // TOTAL MARKED
  // =========================

  static int totalMarked(
    List<int> marked,
  ) {
    return marked.length;
  }

  // =========================
  // COMPLETION %
  // =========================

  static double completionPercent(
    List<List<int?>> ticket,
    List<int> marked,
  ) {
    final numbers = ticket.expand((e) => e).whereType<int>().toList();

    if (numbers.isEmpty) {
      return 0;
    }

    return marked.length / numbers.length;
  }
}
