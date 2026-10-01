class InfluenceHeatEngine {
  // =========================
  // INCREASE
  // =========================

  static int increase({
    required int currentHeat,
    required int amount,
  }) {
    int updated = currentHeat + amount;

    if (updated > 100) {
      updated = 100;
    }

    return updated;
  }

  // =========================
  // DECREASE
  // =========================

  static int decrease({
    required int currentHeat,
    required int amount,
  }) {
    int updated = currentHeat - amount;

    if (updated < 0) {
      updated = 0;
    }

    return updated;
  }

  // =========================
  // PASSIVE COOLING
  // =========================

  static int passiveCooling(
    int currentHeat,
  ) {
    int updated = currentHeat - 2;

    if (updated < 0) {
      updated = 0;
    }

    return updated;
  }

  // =========================
  // HEAT WARNING
  // =========================

  static String? warning(
    int heat,
  ) {
    if (heat >= 85) {
      return "Massive influence distortion detected.";
    }

    if (heat >= 60) {
      return "Players are sensing manipulation.";
    }

    if (heat >= 40) {
      return "Unusual probability shifts detected.";
    }

    return null;
  }

  // =========================
  // CRITICAL
  // =========================

  static bool isCritical(
    int heat,
  ) {
    return heat >= 85;
  }

  // =========================
  // HIGH
  // =========================

  static bool isHigh(
    int heat,
  ) {
    return heat >= 60;
  }

  // =========================
  // MEDIUM
  // =========================

  static bool isMedium(
    int heat,
  ) {
    return heat >= 40;
  }

  // =========================
  // STABLE
  // =========================

  static bool isStable(
    int heat,
  ) {
    return heat < 40;
  }

  // =========================
  // LEVEL LABEL
  // =========================

  static String level(
    int heat,
  ) {
    if (heat >= 85) {
      return "CRITICAL";
    }

    if (heat >= 60) {
      return "HIGH";
    }

    if (heat >= 40) {
      return "MEDIUM";
    }

    return "LOW";
  }
}
