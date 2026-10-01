enum InfluenceActionType {
  delayNumber,
  ghostMark,
  hiddenSwap,
  jamPrediction,
}

extension InfluenceActionInfo on InfluenceActionType {
  // =========================
  // TITLE
  // =========================

  String get title {
    switch (this) {
      case InfluenceActionType.delayNumber:
        return "Delay Number";

      case InfluenceActionType.ghostMark:
        return "Ghost Mark";

      case InfluenceActionType.hiddenSwap:
        return "Hidden Swap";

      case InfluenceActionType.jamPrediction:
        return "Jam Prediction";
    }
  }

  // =========================
  // DESCRIPTION
  // =========================

  String get description {
    switch (this) {
      case InfluenceActionType.delayNumber:
        return "Delay an upcoming number secretly.";

      case InfluenceActionType.ghostMark:
        return "Show a fake mark briefly on tickets.";

      case InfluenceActionType.hiddenSwap:
        return "Swap future numbers without notice.";

      case InfluenceActionType.jamPrediction:
        return "Disrupt another player's prediction.";
    }
  }

  // =========================
  // ENERGY COST
  // =========================

  int get energyCost {
    switch (this) {
      case InfluenceActionType.delayNumber:
        return 15;

      case InfluenceActionType.ghostMark:
        return 20;

      case InfluenceActionType.hiddenSwap:
        return 25;

      case InfluenceActionType.jamPrediction:
        return 18;
    }
  }

  // =========================
  // HEAT GAIN
  // =========================

  int get heatGain {
    switch (this) {
      case InfluenceActionType.delayNumber:
        return 8;

      case InfluenceActionType.ghostMark:
        return 12;

      case InfluenceActionType.hiddenSwap:
        return 15;

      case InfluenceActionType.jamPrediction:
        return 10;
    }
  }

  // =========================
  // ICON
  // =========================

  String get emoji {
    switch (this) {
      case InfluenceActionType.delayNumber:
        return "⏳";

      case InfluenceActionType.ghostMark:
        return "👻";

      case InfluenceActionType.hiddenSwap:
        return "🔀";

      case InfluenceActionType.jamPrediction:
        return "📡";
    }
  }
}
