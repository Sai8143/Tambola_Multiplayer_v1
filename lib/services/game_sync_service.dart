import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/game_state_model.dart';
import '../models/player_model.dart';
import '../models/vote_model.dart';

class GameSyncService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // =========================
  // COLLECTION
  // =========================

  CollectionReference<Map<String, dynamic>> get gameCollection =>
      firestore.collection(
        'game_states',
      );

  // =========================
  // CREATE GAME
  // =========================

  Future<void> createGameState(
    GameStateModel state,
  ) async {
    await gameCollection.doc(state.roomId).set(
          state.toMap(),
        );
  }

  // =========================
  // STREAM GAME
  // =========================

  Stream<GameStateModel> gameStream(
    String roomId,
  ) {
    return gameCollection.doc(roomId).snapshots().map((snapshot) {
      final data = snapshot.data();

      if (data == null) {
        return GameStateModel.initial(
          roomId,
        );
      }

      return GameStateModel.fromMap(data);
    });
  }

  // =========================
  // REGISTER OR UPDATE PLAYER
  // =========================

  Future<void> registerOrUpdatePlayer({
    required String roomId,
    required PlayerModel player,
    String gameMode = 'complex',
  }) async {
    final docRef = gameCollection.doc(roomId);
    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      final initialState = GameStateModel.initial(roomId, gameMode: gameMode).copyWith(
        players: [player],
      );
      await docRef.set(initialState.toMap());
      return;
    }

    final data = snapshot.data() ?? {};
    final state = GameStateModel.fromMap(data);

    List<PlayerModel> existingPlayers = List.from(state.players);
    int index = existingPlayers.indexWhere((p) => p.playerId == player.playerId);

    if (index >= 0) {
      existingPlayers[index] = player;
    } else {
      existingPlayers.add(player);
    }

    await docRef.update({
      'players': existingPlayers.map((e) => e.toMap()).toList(),
    });
  }

  // =========================
  // START GAME
  // =========================

  Future<void> startGame({
    required String roomId,
  }) async {
    await gameCollection.doc(roomId).update({
      'started': true,
      'statusMessage': 'Game Started',
    });
  }

  // =========================
  // UPDATE PLAYERS
  // =========================

  Future<void> updatePlayers({
    required String roomId,
    required List<PlayerModel> players,
  }) async {
    await gameCollection.doc(roomId).update({
      'players': players
          .map(
            (e) => e.toMap(),
          )
          .toList(),
    });
  }

  // =========================
  // UPDATE NUMBER & QUEUE
  // =========================

  Future<void> updateNumberQueue({
    required String roomId,
    required List<int> queue,
    required int? currentNumber,
    required List<int> calledNumbers,
    required int round,
  }) async {
    await gameCollection.doc(roomId).update({
      'numberQueue': queue,
      'currentNumber': currentNumber,
      'calledNumbers': calledNumbers,
      'round': round,
    });
  }

  // =========================
  // UPDATE HEAT
  // =========================

  Future<void> updateInfluenceHeat({
    required String roomId,
    required int heat,
  }) async {
    await gameCollection.doc(roomId).update({
      'influenceHeat': heat,
    });
  }

  // =========================
  // STATUS MESSAGE
  // =========================

  Future<void> updateStatus({
    required String roomId,
    required String message,
  }) async {
    await gameCollection.doc(roomId).update({
      'statusMessage': message,
    });
  }

  // =========================
  // START MEETING
  // =========================

  Future<void> startMeeting({
    required String roomId,
    required EmergencyMeeting meeting,
  }) async {
    await gameCollection.doc(roomId).update({
      'meetingActive': true,
      'meeting': meeting.toMap(),
    });
  }

  // =========================
  // END MEETING
  // =========================

  Future<void> endMeeting({
    required String roomId,
  }) async {
    await gameCollection.doc(roomId).update({
      'meetingActive': false,
      'meeting': EmergencyMeeting.initial().toMap(),
    });
  }

  // =========================
  // SUBMIT VOTE
  // =========================

  Future<void> submitVote({
    required String roomId,
    required VoteModel vote,
    required List<VoteModel> currentVotes,
  }) async {
    final updated = [
      ...currentVotes,
      vote,
    ];

    await gameCollection.doc(roomId).update({
      'meeting.votes': updated
          .map(
            (e) => e.toMap(),
          )
          .toList(),
    });
  }

  // =========================
  // FINISH GAME
  // =========================

  Future<void> finishGame({
    required String roomId,
  }) async {
    await gameCollection.doc(roomId).update({
      'finished': true,
    });
  }
}
