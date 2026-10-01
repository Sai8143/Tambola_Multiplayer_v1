import 'package:flutter/services.dart';

class GameAudioService {
  // =========================
  // NUMBER CALL
  // =========================

  void playNumberCall() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.selectionClick();
  }

  // =========================
  // SUCCESS
  // =========================

  void playSuccess() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.mediumImpact();
  }

  // =========================
  // FAILURE
  // =========================

  void playFailure() {
    HapticFeedback.heavyImpact();
  }

  // =========================
  // VICTORY
  // =========================

  void playVictory() {
    HapticFeedback.heavyImpact();
  }

  // =========================
  // EMERGENCY
  // =========================

  void playEmergencyAlert() {
    HapticFeedback.vibrate();
  }

  // =========================
  // INFLUENCE
  // =========================

  void playInfluenceSound() {
    HapticFeedback.mediumImpact();
  }

  // =========================
  // CLICK
  // =========================

  void playClick() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.selectionClick();
  }
}
