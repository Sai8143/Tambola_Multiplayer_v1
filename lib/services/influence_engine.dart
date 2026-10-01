import '../models/influence_action.dart';
import '../models/player_model.dart';
import 'influence_heat_engine.dart';
import 'number_queue_engine.dart';

class InfluenceEngine {
  // =========================
  // APPLY ACTION
  // =========================

  static Map<String, dynamic> applyAction({
    required InfluenceActionType action,
    required PlayerModel influencer,
    required List<int> queue,
    required int currentHeat,
  }) {
    List<int> updatedQueue = [...queue];

    int updatedHeat = currentHeat;

    String log = '';

    switch (action) {
      // =====================
      // DELAY NUMBER
      // =====================

      case InfluenceActionType.delayNumber:
        updatedQueue = NumberQueueEngine.delayFirstNumber(
          updatedQueue,
        );

        log = "⏳ Fate flow distorted. Upcoming number delayed.";

        break;

      // =====================
      // GHOST MARK
      // =====================

      case InfluenceActionType.ghostMark:
        log = "👻 A ghost mark briefly appeared on someone's ticket.";

        break;

      // =====================
      // HIDDEN SWAP
      // =====================

      case InfluenceActionType.hiddenSwap:
        updatedQueue = NumberQueueEngine.swapUpcoming(
          updatedQueue,
        );

        log = "🔀 Future numbers were secretly rearranged.";

        break;

      // =====================
      // JAM PREDICTION
      // =====================

      case InfluenceActionType.jamPrediction:
        log = "📡 A prediction signal was disrupted.";

        break;
    }

    // =========================
    // HEAT UPDATE
    // =========================

    updatedHeat = InfluenceHeatEngine.increase(
      currentHeat: updatedHeat,
      amount: action.heatGain,
    );

    // =========================
    // ENERGY UPDATE
    // =========================

    final updatedPlayer = influencer.copyWith(
      influenceEnergy: influencer.influenceEnergy - action.energyCost,
    );

    return {
      'queue': updatedQueue,
      'heat': updatedHeat,
      'player': updatedPlayer,
      'log': log,
    };
  }

  // =========================
  // REGENERATE ENERGY
  // =========================

  static PlayerModel regenerateEnergy(
    PlayerModel player,
  ) {
    int updated = player.influenceEnergy + 5;

    if (updated > 100) {
      updated = 100;
    }

    return player.copyWith(
      influenceEnergy: updated,
    );
  }

  // =========================
  // CAN USE ACTION
  // =========================

  static bool canUseAction({
    required PlayerModel player,
    required InfluenceActionType action,
  }) {
    return player.influenceEnergy >= action.energyCost;
  }
}
