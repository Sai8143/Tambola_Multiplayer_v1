class VoteModel {
  final String voterId;

  final String targetPlayerId;

  const VoteModel({
    required this.voterId,
    required this.targetPlayerId,
  });

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {
    return {
      'voterId': voterId,
      'targetPlayerId': targetPlayerId,
    };
  }

  // =========================
  // FROM MAP
  // =========================

  factory VoteModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return VoteModel(
      voterId: map['voterId'] ?? '',
      targetPlayerId: map['targetPlayerId'] ?? '',
    );
  }

  // =========================
  // COPY WITH
  // =========================

  VoteModel copyWith({
    String? voterId,
    String? targetPlayerId,
  }) {
    return VoteModel(
      voterId: voterId ?? this.voterId,
      targetPlayerId: targetPlayerId ?? this.targetPlayerId,
    );
  }
}

// =============================
// EMERGENCY MEETING MODEL
// =============================

class EmergencyMeeting {
  final bool active;

  final String triggeredBy;

  final List<VoteModel> votes;

  final int remainingSeconds;

  const EmergencyMeeting({
    required this.active,
    required this.triggeredBy,
    required this.votes,
    required this.remainingSeconds,
  });

  // =========================
  // INITIAL
  // =========================

  factory EmergencyMeeting.initial() {
    return const EmergencyMeeting(
      active: false,
      triggeredBy: '',
      votes: [],
      remainingSeconds: 0,
    );
  }

  // =========================
  // TO MAP
  // =========================

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'triggeredBy': triggeredBy,
      'votes': votes
          .map(
            (e) => e.toMap(),
          )
          .toList(),
      'remainingSeconds': remainingSeconds,
    };
  }

  // =========================
  // FROM MAP
  // =========================

  factory EmergencyMeeting.fromMap(
    Map<String, dynamic> map,
  ) {
    return EmergencyMeeting(
      active: map['active'] ?? false,
      triggeredBy: map['triggeredBy'] ?? '',
      votes: (map['votes'] as List?)
              ?.map(
                (e) => VoteModel.fromMap(
                  Map<String, dynamic>.from(
                    e,
                  ),
                ),
              )
              .toList() ??
          [],
      remainingSeconds: map['remainingSeconds'] ?? 0,
    );
  }

  // =========================
  // COPY WITH
  // =========================

  EmergencyMeeting copyWith({
    bool? active,
    String? triggeredBy,
    List<VoteModel>? votes,
    int? remainingSeconds,
  }) {
    return EmergencyMeeting(
      active: active ?? this.active,
      triggeredBy: triggeredBy ?? this.triggeredBy,
      votes: votes ?? this.votes,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}
