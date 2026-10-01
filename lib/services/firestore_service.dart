import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // =========================
  // COLLECTION
  // =========================

  CollectionReference<Map<String, dynamic>> get rooms => firestore.collection(
        'rooms',
      );

  // =========================
  // CREATE ROOM
  // =========================

  Future<void> createRoom(
    String roomId, {
    String gameMode = 'complex',
  }) async {
    await rooms.doc(roomId).set({
      'roomId': roomId,
      'gameMode': gameMode,
      'createdAt': FieldValue.serverTimestamp(),
      'active': true,
    });
  }

  // =========================
  // ROOM EXISTS
  // =========================

  Future<bool> roomExists(
    String roomId,
  ) async {
    final snapshot = await rooms.doc(roomId).get();

    return snapshot.exists;
  }

  // =========================
  // JOIN ROOM
  // =========================

  Future<void> joinRoom(
    String roomId,
  ) async {
    final doc = await rooms.doc(roomId).get();

    if (!doc.exists) {
      throw Exception(
        'Room not found',
      );
    }
  }

  // =========================
  // DELETE ROOM
  // =========================

  Future<void> deleteRoom(
    String roomId,
  ) async {
    await rooms.doc(roomId).delete();
  }

  // =========================
  // LEAVE ROOM
  // =========================

  Future<void> leaveRoom(
    String roomId,
  ) async {
    final exists = await roomExists(
      roomId,
    );

    if (!exists) {
      return;
    }
  }

  // =========================
  // UPDATE STATUS
  // =========================

  Future<void> updateRoomStatus({
    required String roomId,
    required bool active,
  }) async {
    await rooms.doc(roomId).update({
      'active': active,
    });
  }

  // =========================
  // GET ROOM
  // =========================

  Future<DocumentSnapshot<Map<String, dynamic>>> getRoom(
    String roomId,
  ) async {
    return await rooms.doc(roomId).get();
  }
}
