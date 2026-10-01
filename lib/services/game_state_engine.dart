import '../models/player_model.dart';
import '../models/player_role.dart';
import '../models/vote_model.dart';
import 'voting_engine.dart';

class GameStateEngine {
  // =========================
  // NORMAL PLAYERS WIN
  // =========================

  static bool normalPlayersWin(
    List<PlayerModel> players,
  ) {
    final influencers = players
        .where(
          (p) => p.role == PlayerRole.influencer && !p.isEliminated,
        )
        .toList();

    return influencers.isEmpty;
  }

  // =========================
  // INFLUENCERS WIN
  // =========================

  static bool influencersWin(
    List<PlayerModel> players,
  ) {
    final influencers = players
        .where(
          (p) => p.role == PlayerRole.influencer && !p.isEliminated,
        )
        .length;

    final normalPlayers = players
        .where(
          (p) => p.role == PlayerRole.normal && !p.isEliminated,
        )
        .length;

    return influencers > 0 && influencers >= normalPlayers;
  }

  // =========================
  // PROCESS MEETING
  // =========================

  static List<PlayerModel> processMeetingResult({
    required List<PlayerModel> players,
    required List<VoteModel> votes,
  }) {
    final votedId = VotingEngine.getMostVotedPlayerId(
      votes,
    );

    if (votedId == null) {
      return players;
    }

    return VotingEngine.eliminatePlayer(
      players,
      votedId,
    );
  }

  // =========================
  // BUILD SUMMARY
  // =========================

  static String buildMeetingSummary({
    required List<PlayerModel> players,
    required List<VoteModel> votes,
  }) {
    final votedId = VotingEngine.getMostVotedPlayerId(
      votes,
    );

    if (votedId == null) {
      return "No player was eliminated.";
    }

    final player = players.firstWhere(
      (p) => p.playerId == votedId,
    );

    final correct = player.role == PlayerRole.influencer;

    return VotingEngine.buildResultMessage(
      correctVote: correct,
      playerName: player.playerName,
    );
  }

  // =========================
  // GAME MESSAGE
  // =========================

  static String gameOverMessage({
    required bool influencersWon,
  }) {
    if (influencersWon) {
      return "🕵️ Influencers dominated the fate system.";
    }

    return "🎉 Normal players exposed all influencers.";
  }

  // =========================
  // ACTIVE PLAYERS
  // =========================

  static List<PlayerModel> activePlayers(
    List<PlayerModel> players,
  ) {
    return players
        .where(
          (p) => !p.isEliminated,
        )
        .toList();
  }

  // =========================
  // ONLINE PLAYERS
  // =========================

  static List<PlayerModel> onlinePlayers(
    List<PlayerModel> players,
  ) {
    return players
        .where(
          (p) => p.isOnline,
        )
        .toList();
  }
}
