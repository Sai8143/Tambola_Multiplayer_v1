import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerPresenceService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // =========================
  // COLLECTION
  // =========================

  static CollectionReference<Map<String, dynamic>> get presenceCollection =>
      firestore.collection(
        'player_presence',
      );

  // =========================
  // SET ONLINE
  // =========================

  static Future<void> setOnline({
    required String roomId,
    required String playerId,
  }) async {
    await presenceCollection
        .doc(
      '${roomId}_$playerId',
    )
        .set({
      'roomId': roomId,
      'playerId': playerId,
      'online': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // =========================
  // SET OFFLINE
  // =========================

  static Future<void> setOffline({
    required String roomId,
    required String playerId,
  }) async {
    await presenceCollection
        .doc(
      '${roomId}_$playerId',
    )
        .set({
      'roomId': roomId,
      'playerId': playerId,
      'online': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // =========================
  // PLAYER ONLINE?
  // =========================

  static Future<bool> isOnline({
    required String roomId,
    required String playerId,
  }) async {
    final snapshot = await presenceCollection
        .doc(
          '${roomId}_$playerId',
        )
        .get();

    if (!snapshot.exists) {
      return false;
    }

    final data = snapshot.data();

    if (data == null) {
      return false;
    }

    return data['online'] ?? false;
  }

  // =========================
  // STREAM ROOM PLAYERS
  // =========================

  static Stream<QuerySnapshot<Map<String, dynamic>>> roomPresence(
    String roomId,
  ) {
    return presenceCollection
        .where(
          'roomId',
          isEqualTo: roomId,
        )
        .snapshots();
  }
}
