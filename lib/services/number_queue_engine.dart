import 'dart:math';

class NumberQueueEngine {
  // =========================
  // GENERATE QUEUE
  // =========================

  static List<int> generateQueue() {
    final numbers = List.generate(
      90,
      (index) => index + 1,
    );

    numbers.shuffle(
      Random(),
    );

    return numbers;
  }

  // =========================
  // NEXT NUMBER
  // =========================

  static int? nextNumber(
    List<int> queue,
  ) {
    if (queue.isEmpty) {
      return null;
    }

    return queue.first;
  }

  // =========================
  // REMOVE FIRST
  // =========================

  static List<int> consumeNumber(
    List<int> queue,
  ) {
    if (queue.isEmpty) {
      return [];
    }

    return queue.sublist(1).toList();
  }

  // =========================
  // PREVIEW
  // =========================

  static List<int> upcomingPreview(
    List<int> queue,
    int count,
  ) {
    if (queue.isEmpty) {
      return [];
    }

    if (queue.length < count) {
      return queue;
    }

    return queue.take(count).toList();
  }

  // =========================
  // DELAY NUMBER
  // =========================

  static List<int> delayFirstNumber(
    List<int> queue,
  ) {
    if (queue.length < 2) {
      return queue;
    }

    final updated = [
      ...queue,
    ];

    final first = updated.removeAt(0);

    updated.insert(
      min(5, updated.length),
      first,
    );

    return updated;
  }

  // =========================
  // SWAP UPCOMING
  // =========================

  static List<int> swapUpcoming(
    List<int> queue,
  ) {
    if (queue.length < 3) {
      return queue;
    }

    final updated = [
      ...queue,
    ];

    final temp = updated[0];

    updated[0] = updated[1];

    updated[1] = temp;

    return updated;
  }

  // =========================
  // ADD NUMBER BACK
  // =========================

  static List<int> insertBack(
    List<int> queue,
    int number,
  ) {
    final updated = [
      ...queue,
    ];

    updated.add(number);

    return updated;
  }

  // =========================
  // HAS NUMBER
  // =========================

  static bool contains(
    List<int> queue,
    int number,
  ) {
    return queue.contains(
      number,
    );
  }

  // =========================
  // REMAINING COUNT
  // =========================

  static int remaining(
    List<int> queue,
  ) {
    return queue.length;
  }
}
