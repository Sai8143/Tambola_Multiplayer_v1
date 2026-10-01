import '../models/player_model.dart';
import '../models/player_role.dart';

class SuspicionEngine {
  // =========================
  // CALCULATE PLAYER SUSPICION
  // =========================

  static List<PlayerModel> updateRoomSuspicion({
    required List<PlayerModel> players,
    required int roomHeat,
  }) {
    return players.map((player) {
      int base = player.suspicionScore;

      // High heat naturally increases ambient suspicion for Influencers or heavy actors
      if (roomHeat > 60 && player.role == PlayerRole.influencer) {
        base = (base + 2).clamp(0, 100);
      }

      return player.copyWith(suspicionScore: base);
    }).toList();
  }

  // =========================
  // ADD SUSPICION EVENT
  // =========================

  static PlayerModel addSuspicion(PlayerModel player, int delta) {
    final updatedScore = (player.suspicionScore + delta).clamp(0, 100);
    return player.copyWith(suspicionScore: updatedScore);
  }

  // =========================
  // SUSPICION LEVEL LABEL
  // =========================

  static String getLabel(int suspicionScore) {
    if (suspicionScore >= 80) return "CRITICAL";
    if (suspicionScore >= 55) return "HIGH";
    if (suspicionScore >= 30) return "MODERATE";
    return "LOW";
  }
}
