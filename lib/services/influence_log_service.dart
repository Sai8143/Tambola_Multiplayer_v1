class InfluenceLogService {
  // =========================
  // LOG STORAGE
  // =========================

  static final List<String> logs = [];

  // =========================
  // ADD LOG
  // =========================

  static void addLog(
    String message,
  ) {
    logs.insert(
      0,
      message,
    );

    trimLogs();
  }

  // =========================
  // INFLUENCE DETECTED
  // =========================

  static void influenceDetected(
    String message,
  ) {
    addLog(
      "👀 $message",
    );
  }

  // =========================
  // MEETING STARTED
  // =========================

  static void meetingStarted(
    String playerName,
  ) {
    addLog(
      "🚨 $playerName triggered an emergency meeting.",
    );
  }

  // =========================
  // VOTE SUBMITTED
  // =========================

  static void voteSubmitted(
    String playerName,
  ) {
    addLog(
      "🗳 $playerName submitted a vote.",
    );
  }

  // =========================
  // NUMBER CALLED
  // =========================

  static void numberCalled(
    int number,
  ) {
    addLog(
      "🎟 Number called: $number",
    );
  }

  // =========================
  // PREDICTION
  // =========================

  static void predictionResult({
    required bool success,
    required String prediction,
  }) {
    addLog(
      success
          ? "✅ Prediction succeeded: $prediction"
          : "❌ Prediction failed: $prediction",
    );
  }

  // =========================
  // CLEAR
  // =========================

  static void clear() {
    logs.clear();
  }

  // =========================
  // LIMIT
  // =========================

  static void trimLogs() {
    if (logs.length > 30) {
      logs.removeLast();
    }
  }
}
