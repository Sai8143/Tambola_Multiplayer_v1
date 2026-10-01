import 'dart:async';

class MeetingTimerService {
  Timer? _timer;

  int _remainingSeconds = 0;

  Function(int seconds)? onTick;

  Function()? onCompleted;

  // =========================
  // START
  // =========================

  void start({
    required int duration,
    Function(int seconds)? tick,
    Function()? completed,
  }) {
    stop();

    _remainingSeconds = duration;

    onTick = tick;

    onCompleted = completed;

    onTick?.call(
      _remainingSeconds,
    );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _remainingSeconds--;

        onTick?.call(
          _remainingSeconds,
        );

        if (_remainingSeconds <= 0) {
          stop();

          onCompleted?.call();
        }
      },
    );
  }

  // =========================
  // STOP
  // =========================

  void stop() {
    _timer?.cancel();

    _timer = null;
  }

  // =========================
  // GETTERS
  // =========================

  bool get isRunning => _timer != null;

  int get remainingSeconds => _remainingSeconds;
}
