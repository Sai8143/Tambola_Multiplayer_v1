import '../models/player_model.dart';
import '../models/player_role.dart';
import '../models/vote_model.dart';

class VotingEngine {
  // =========================
  // HAS PLAYER VOTED
  // =========================

  static bool hasPlayerVoted({
    required List<VoteModel> votes,
    required String playerId,
  }) {
    return votes.any(
      (v) => v.voterId == playerId,
    );
  }

  // =========================
  // MOST VOTED PLAYER
  // =========================

  static String? getMostVotedPlayerId(
    List<VoteModel> votes,
  ) {
    if (votes.isEmpty) {
      return null;
    }

    final Map<String, int> counts = {};

    for (final vote in votes) {
      counts[vote.targetPlayerId] = (counts[vote.targetPlayerId] ?? 0) + 1;
    }

    String? winner;

    int highest = 0;

    counts.forEach(
      (playerId, count) {
        if (count > highest) {
          highest = count;

          winner = playerId;
        }
      },
    );

    return winner;
  }

  // =========================
  // ELIMINATE PLAYER
  // =========================

  static List<PlayerModel> eliminatePlayer(
    List<PlayerModel> players,
    String playerId,
  ) {
    return players.map((p) {
      if (p.playerId != playerId) {
        return p;
      }

      return p.copyWith(
        isEliminated: true,
      );
    }).toList();
  }

  // =========================
  // FIND PLAYER
  // =========================

  static PlayerModel? findPlayer(
    List<PlayerModel> players,
    String playerId,
  ) {
    try {
      return players.firstWhere(
        (p) => p.playerId == playerId,
      );
    } catch (_) {
      return null;
    }
  }

  // =========================
  // IS CORRECT VOTE
  // =========================

  static bool isCorrectVote(
    PlayerModel player,
  ) {
    return player.role == PlayerRole.influencer;
  }

  // =========================
  // RESULT MESSAGE
  // =========================

  static String buildResultMessage({
    required bool correctVote,
    required String playerName,
  }) {
    if (correctVote) {
      return "🕵️ $playerName was exposed as an Influencer.";
    }

    return "❌ $playerName was innocent.";
  }

  // =========================
  // ALL PLAYERS VOTED
  // =========================

  static bool allPlayersVoted({
    required List<PlayerModel> players,
    required List<VoteModel> votes,
  }) {
    final activePlayers = players
        .where(
          (p) => !p.isEliminated,
        )
        .length;

    return votes.length >= activePlayers;
  }
}
