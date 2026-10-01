import 'dart:math';

import '../models/player_model.dart';
import '../models/player_role.dart';

class RoleEngine {
  // =========================
  // ASSIGN ROLES
  // =========================

  static List<PlayerModel> assignRoles(
    List<PlayerModel> players,
  ) {
    if (players.isEmpty) {
      return [];
    }

    final random = Random();

    final updatedPlayers = [...players];

    // =====================
    // RESET ALL TO NORMAL
    // =====================

    for (int i = 0; i < updatedPlayers.length; i++) {
      updatedPlayers[i] = updatedPlayers[i].copyWith(
        role: PlayerRole.normal,
      );
    }

    // =====================
    // SELECT INFLUENCER
    // =====================

    final influencerIndex = random.nextInt(
      updatedPlayers.length,
    );

    updatedPlayers[influencerIndex] = updatedPlayers[influencerIndex].copyWith(
      role: PlayerRole.influencer,
      influenceEnergy: 100,
    );

    return updatedPlayers;
  }

  // =========================
  // GET INFLUENCERS
  // =========================

  static List<PlayerModel> influencers(
    List<PlayerModel> players,
  ) {
    return players
        .where(
          (p) => p.role == PlayerRole.influencer,
        )
        .toList();
  }

  // =========================
  // GET NORMAL PLAYERS
  // =========================

  static List<PlayerModel> normalPlayers(
    List<PlayerModel> players,
  ) {
    return players
        .where(
          (p) => p.role == PlayerRole.normal,
        )
        .toList();
  }

  // =========================
  // IS INFLUENCER
  // =========================

  static bool isInfluencer(
    PlayerModel player,
  ) {
    return player.role == PlayerRole.influencer;
  }

  // =========================
  // COUNT INFLUENCERS
  // =========================

  static int influencerCount(
    List<PlayerModel> players,
  ) {
    return influencers(players).length;
  }

  // =========================
  // COUNT NORMALS
  // =========================

  static int normalCount(
    List<PlayerModel> players,
  ) {
    return normalPlayers(players).length;
  }
}
