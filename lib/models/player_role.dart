enum PlayerRole {
  normal,
  influencer,
}

extension PlayerRoleInfo on PlayerRole {
  // =========================
  // TITLE
  // =========================

  String get title {
    switch (this) {
      case PlayerRole.normal:
        return "Normal Player";

      case PlayerRole.influencer:
        return "Influencer";
    }
  }

  // =========================
  // DESCRIPTION
  // =========================

  String get description {
    switch (this) {
      case PlayerRole.normal:
        return "Complete your ticket and expose hidden manipulators.";

      case PlayerRole.influencer:
        return "Manipulate fate secretly while avoiding suspicion.";
    }
  }

  // =========================
  // EMOJI
  // =========================

  String get emoji {
    switch (this) {
      case PlayerRole.normal:
        return "🎟";

      case PlayerRole.influencer:
        return "🕵️";
    }
  }

  // =========================
  // COLOR
  // =========================

  int get colorValue {
    switch (this) {
      case PlayerRole.normal:
        return 0xFF4F46E5;

      case PlayerRole.influencer:
        return 0xFFDC2626;
    }
  }

  // =========================
  // SHORT LABEL
  // =========================

  String get shortLabel {
    switch (this) {
      case PlayerRole.normal:
        return "PLAYER";

      case PlayerRole.influencer:
        return "INFLUENCER";
    }
  }
}
