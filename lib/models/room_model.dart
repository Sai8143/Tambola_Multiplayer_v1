import 'player_role.dart';

class PlayerModel {
  final String playerId;

  final String playerName;

  final bool isHost;

  final bool isOnline;

  final bool isEliminated;

  final PlayerRole role;

  final List<List<int?>> ticket;

  final List<int> markedNumbers;

  final int suspicionScore;

  final int influenceEnergy;

  final int predictionScore;

  final int emergencyMeetingsLeft;

  const PlayerModel({
    required this.playerId,
    required this.playerName,
    required this.isHost,
    required this.isOnline,
    required this.isEliminated,
    required this.role,
    required this.ticket,
    required this.markedNumbers,
    required this.suspicionScore,
    required this.influenceEnergy,
    required this.predictionScore,
    required this.emergencyMeetingsLeft,
  });

  // =========================
  // INITIAL
  // =========================

  factory PlayerModel.initial({
    required String playerId,
    required String playerName,
    required bool isHost,
    required List<List<int?>> ticket,
  }) {
    return PlayerModel(
      playerId: playerId,
      playerName: playerName,
      isHost: isHost,
      isOnline: true,
      isEliminated: false,
      role: PlayerRole.normal,
      ticket: ticket,
      markedNumbers: [],
      suspicionScore: 0,
      influenceEnergy: 100,
      predictionScore: 0,
      emergencyMeetingsLeft: 2,
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {
    return {
      'playerId': playerId,
      'playerName': playerName,
      'isHost': isHost,
      'isOnline': isOnline,
      'isEliminated': isEliminated,
      'role': role.name,
      'ticket': ticket,
      'markedNumbers': markedNumbers,
      'suspicionScore': suspicionScore,
      'influenceEnergy': influenceEnergy,
      'predictionScore': predictionScore,
      'emergencyMeetingsLeft': emergencyMeetingsLeft,
    };
  }

  // =========================
  // FROM MAP
  // =========================

  factory PlayerModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return PlayerModel(
      playerId: map['playerId'] ?? '',
      playerName: map['playerName'] ?? '',
      isHost: map['isHost'] ?? false,
      isOnline: map['isOnline'] ?? false,
      isEliminated: map['isEliminated'] ?? false,
      role: map['role'] == 'influencer'
          ? PlayerRole.influencer
          : PlayerRole.normal,
      ticket: (map['ticket'] as List)
          .map<List<int?>>(
            (row) => List<int?>.from(row),
          )
          .toList(),
      markedNumbers: List<int>.from(
        map['markedNumbers'] ?? [],
      ),
      suspicionScore: map['suspicionScore'] ?? 0,
      influenceEnergy: map['influenceEnergy'] ?? 100,
      predictionScore: map['predictionScore'] ?? 0,
      emergencyMeetingsLeft: map['emergencyMeetingsLeft'] ?? 2,
    );
  }

  // =========================
  // COPY WITH
  // =========================

  PlayerModel copyWith({
    String? playerId,
    String? playerName,
    bool? isHost,
    bool? isOnline,
    bool? isEliminated,
    PlayerRole? role,
    List<List<int?>>? ticket,
    List<int>? markedNumbers,
    int? suspicionScore,
    int? influenceEnergy,
    int? predictionScore,
    int? emergencyMeetingsLeft,
  }) {
    return PlayerModel(
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      isHost: isHost ?? this.isHost,
      isOnline: isOnline ?? this.isOnline,
      isEliminated: isEliminated ?? this.isEliminated,
      role: role ?? this.role,
      ticket: ticket ?? this.ticket,
      markedNumbers: markedNumbers ?? this.markedNumbers,
      suspicionScore: suspicionScore ?? this.suspicionScore,
      influenceEnergy: influenceEnergy ?? this.influenceEnergy,
      predictionScore: predictionScore ?? this.predictionScore,
      emergencyMeetingsLeft:
          emergencyMeetingsLeft ?? this.emergencyMeetingsLeft,
    );
  }
}
