import 'dart:async';

class TimerHelper {
  Timer? _timer;
  int _remainingSeconds = 0;

  Function(int seconds)? onTick;
  Function()? onFinished;

  void startTimer({
    required int seconds,
    Function(int seconds)? onTick,
    Function()? onFinished,
  }) {
    _remainingSeconds = seconds;
    this.onTick = onTick;
    this.onFinished = onFinished;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        if (this.onFinished != null) {
          this.onFinished!();
        }
      } else {
        _remainingSeconds--;
        if (this.onTick != null) {
          this.onTick!(_remainingSeconds);
        }
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  int get remainingSeconds => _remainingSeconds;

  static String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;

    final minStr = minutes.toString().padLeft(2, '0');
    final secStr = remaining.toString().padLeft(2, '0');

    return "$minStr:$secStr";
  }
}