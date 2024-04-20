import 'dart:async'; // Import dart:async for Timer

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  bool _isRunning = false;

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _startStopwatch() {
    if (_isRunning) {
      _stopwatch.stop();
      _timer.cancel(); // Cancel timer when stopwatch stops
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), _updateTimer);
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _timer.cancel(); // Cancel timer when stopwatch resets
    setState(() {
      _isRunning = false;
    });
  }

  void _updateTimer(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel(); // Stop updating when stopwatch is not running
    }
  }

  String _formatMilliseconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate() % 60;
    int hours = (milliseconds / (1000 * 60 * 60)).truncate();

    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr:$hundredsStr';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formatMilliseconds(_stopwatch.elapsedMilliseconds);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formattedTime,
              style: const TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
