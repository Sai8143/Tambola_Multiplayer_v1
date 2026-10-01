import 'player_model.dart';
import 'vote_model.dart';

class GameStateModel {
  final String roomId;
  final String gameMode; // 'simple' (Classic Tambola) or 'complex' (Fate Tickets)
  final List<int> numberQueue;
  final List<PlayerModel> players;
  final List<int> calledNumbers;
  final int? currentNumber;
  final int round;
  final int influenceHeat;
  final bool started;
  final bool finished;
  final bool meetingActive;
  final EmergencyMeeting meeting;
  final String statusMessage;

  const GameStateModel({
    required this.roomId,
    this.gameMode = 'complex',
    this.numberQueue = const [],
    required this.players,
    required this.calledNumbers,
    required this.currentNumber,
    required this.round,
    required this.influenceHeat,
    required this.started,
    required this.finished,
    required this.meetingActive,
    required this.meeting,
    required this.statusMessage,
  });

  // =========================
  // INITIAL
  // =========================

  factory GameStateModel.initial(
    String roomId, {
    String gameMode = 'complex',
  }) {
    return GameStateModel(
      roomId: roomId,
      gameMode: gameMode,
      numberQueue: [],
      players: [],
      calledNumbers: [],
      currentNumber: null,
      round: 0,
      influenceHeat: 0,
      started: false,
      finished: false,
      meetingActive: false,
      meeting: EmergencyMeeting.initial(),
      statusMessage: "Waiting for players...",
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'gameMode': gameMode,
      'numberQueue': numberQueue,
      'players': players.map((e) => e.toMap()).toList(),
      'calledNumbers': calledNumbers,
      'currentNumber': currentNumber,
      'round': round,
      'influenceHeat': influenceHeat,
      'started': started,
      'finished': finished,
      'meetingActive': meetingActive,
      'meeting': meeting.toMap(),
      'statusMessage': statusMessage,
    };
  }

  // =========================
  // FROM MAP
  // =========================

  factory GameStateModel.fromMap(Map<String, dynamic> map) {
    return GameStateModel(
      roomId: map['roomId'] ?? '',
      gameMode: map['gameMode'] ?? 'complex',
      numberQueue: List<int>.from(map['numberQueue'] ?? []),
      players: (map['players'] as List?)
              ?.map(
                (e) => PlayerModel.fromMap(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList() ??
          [],
      calledNumbers: List<int>.from(map['calledNumbers'] ?? []),
      currentNumber: map['currentNumber'],
      round: map['round'] ?? 0,
      influenceHeat: map['influenceHeat'] ?? 0,
      started: map['started'] ?? false,
      finished: map['finished'] ?? false,
      meetingActive: map['meetingActive'] ?? false,
      meeting: map['meeting'] != null
          ? EmergencyMeeting.fromMap(
              Map<String, dynamic>.from(map['meeting']),
            )
          : EmergencyMeeting.initial(),
      statusMessage: map['statusMessage'] ?? '',
    );
  }

  // =========================
  // COPY WITH
  // =========================

  GameStateModel copyWith({
    String? roomId,
    String? gameMode,
    List<int>? numberQueue,
    List<PlayerModel>? players,
    List<int>? calledNumbers,
    int? currentNumber,
    int? round,
    int? influenceHeat,
    bool? started,
    bool? finished,
    bool? meetingActive,
    EmergencyMeeting? meeting,
    String? statusMessage,
  }) {
    return GameStateModel(
      roomId: roomId ?? this.roomId,
      gameMode: gameMode ?? this.gameMode,
      numberQueue: numberQueue ?? this.numberQueue,
      players: players ?? this.players,
      calledNumbers: calledNumbers ?? this.calledNumbers,
      currentNumber: currentNumber ?? this.currentNumber,
      round: round ?? this.round,
      influenceHeat: influenceHeat ?? this.influenceHeat,
      started: started ?? this.started,
      finished: finished ?? this.finished,
      meetingActive: meetingActive ?? this.meetingActive,
      meeting: meeting ?? this.meeting,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}
