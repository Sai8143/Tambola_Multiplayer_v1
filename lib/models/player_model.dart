import 'player_role.dart';

class PlayerModel {
  final String playerId;

  final String playerName;

  final PlayerRole role;

  final bool isHost;

  final bool isOnline;

  final bool isEliminated;

  final int suspicionScore;

  final int trustScore;

  final int influenceEnergy;

  final int predictionScore;

  final int emergencyMeetingsLeft;

  final List<int> markedNumbers;

  final List<List<int?>> ticket;

  const PlayerModel({
    required this.playerId,
    required this.playerName,
    required this.role,
    required this.isHost,
    required this.isOnline,
    required this.isEliminated,
    required this.suspicionScore,
    required this.trustScore,
    required this.influenceEnergy,
    required this.predictionScore,
    required this.emergencyMeetingsLeft,
    required this.markedNumbers,
    required this.ticket,
  });

  // =========================
  // INITIAL PLAYER
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
      role: PlayerRole.normal,
      isHost: isHost,
      isOnline: true,
      isEliminated: false,
      suspicionScore: 0,
      trustScore: 100,
      influenceEnergy: 100,
      predictionScore: 0,
      emergencyMeetingsLeft: 2,
      markedNumbers: [],
      ticket: ticket,
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {
    return {
      'playerId': playerId,
      'playerName': playerName,
      'role': role.name,
      'isHost': isHost,
      'isOnline': isOnline,
      'isEliminated': isEliminated,
      'suspicion': suspicionScore,
      'trustScore': trustScore,
      'influenceEnergy': influenceEnergy,
      'predictionScore': predictionScore,
      'emergencyMeetingsLeft': emergencyMeetingsLeft,
      'markedNumbers': markedNumbers,
      'ticket': {
        'row0': ticket.isNotEmpty ? ticket[0] : [],
        'row1': ticket.length > 1 ? ticket[1] : [],
        'row2': ticket.length > 2 ? ticket[2] : [],
      },
    };
  }

  // =========================
  // FROM MAP
  // =========================

  factory PlayerModel.fromMap(
    Map<String, dynamic> map,
  ) {
    List<List<int?>> parsedTicket = [];
    final ticketData = map['ticket'];

    if (ticketData is Map) {
      parsedTicket = [
        List<int?>.from(ticketData['row0'] ?? []),
        List<int?>.from(ticketData['row1'] ?? []),
        List<int?>.from(ticketData['row2'] ?? []),
      ];
    } else if (ticketData is List) {
      parsedTicket = ticketData
          .map(
            (row) => List<int?>.from(
              row is List ? row : [],
            ),
          )
          .toList();
    }

    return PlayerModel(
      playerId: map['playerId'] ?? '',
      playerName: map['playerName'] ?? '',
      role: _roleFromString(
        map['role'] ?? 'normal',
      ),
      isHost: map['isHost'] ?? false,
      isOnline: map['isOnline'] ?? true,
      isEliminated: map['isEliminated'] ?? false,
      suspicionScore: map['suspicion'] ?? 0,
      trustScore: map['trustScore'] ?? 100,
      influenceEnergy: map['influenceEnergy'] ?? 100,
      predictionScore: map['predictionScore'] ?? 0,
      emergencyMeetingsLeft: map['emergencyMeetingsLeft'] ?? 2,
      markedNumbers: List<int>.from(
        map['markedNumbers'] ?? [],
      ),
      ticket: parsedTicket,
    );
  }

  // =========================
  // COPY WITH
  // =========================

  PlayerModel copyWith({
    String? playerId,
    String? playerName,
    PlayerRole? role,
    bool? isHost,
    bool? isOnline,
    bool? isEliminated,
    int? suspicionScore,
    int? trustScore,
    int? influenceEnergy,
    int? predictionScore,
    int? emergencyMeetingsLeft,
    List<int>? markedNumbers,
    List<List<int?>>? ticket,
  }) {
    return PlayerModel(
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      role: role ?? this.role,
      isHost: isHost ?? this.isHost,
      isOnline: isOnline ?? this.isOnline,
      isEliminated: isEliminated ?? this.isEliminated,
      suspicionScore: suspicionScore ?? this.suspicionScore,
      trustScore: trustScore ?? this.trustScore,
      influenceEnergy: influenceEnergy ?? this.influenceEnergy,
      predictionScore: predictionScore ?? this.predictionScore,
      emergencyMeetingsLeft:
          emergencyMeetingsLeft ?? this.emergencyMeetingsLeft,
      markedNumbers: markedNumbers ?? this.markedNumbers,
      ticket: ticket ?? this.ticket,
    );
  }

  // =========================
  // ROLE PARSER
  // =========================

  static PlayerRole _roleFromString(
    String role,
  ) {
    switch (role) {
      case 'influencer':
        return PlayerRole.influencer;

      default:
        return PlayerRole.normal;
    }
  }
}
