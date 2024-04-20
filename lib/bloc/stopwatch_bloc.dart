import 'dart:async';
import 'package:bloc/bloc.dart';

// Events
enum StopwatchEvent {
  start,
  pause,
  reset,
  tick,
}

// States
class StopwatchState {
  final Duration duration;
  final bool isRunning;

  StopwatchState({required this.duration, required this.isRunning});

  factory StopwatchState.initial() => StopwatchState(duration: Duration.zero, isRunning: false);
}

// Bloc
class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  late Timer _timer;
  late Duration _duration;

  StopwatchBloc() : super(StopwatchState.initial());

  @override
  Stream<StopwatchState> mapEventToState(StopwatchEvent event) async* {
    if (event == StopwatchEvent.start) {
      yield* _startStopwatch();
    } else if (event == StopwatchEvent.pause) {
      yield* _pauseStopwatch();
    } else if (event == StopwatchEvent.reset) {
      yield* _resetStopwatch();
    } else if (event == StopwatchEvent.tick) {
      yield* _tickStopwatch();
    }
  }

  Stream<StopwatchState> _startStopwatch() async* {
    _duration = state.duration;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      add(StopwatchEvent.tick);
    });
    yield StopwatchState(duration: _duration, isRunning: true);
  }

  Stream<StopwatchState> _pauseStopwatch() async* {
    _timer.cancel();
    yield StopwatchState(duration: _duration, isRunning: false);
  }

  Stream<StopwatchState> _resetStopwatch() async* {
    _timer.cancel();
    _duration = Duration.zero;
    yield StopwatchState(duration: _duration, isRunning: false);
  }

  Stream<StopwatchState> _tickStopwatch() async* {
    _duration += const Duration(milliseconds: 10);
    yield StopwatchState(duration: _duration, isRunning: true);
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
