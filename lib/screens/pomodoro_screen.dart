import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async'; // Import async for Timer

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  late Timer _timer;
  int _workDurationSeconds = 25 * 60; // 25 minutes work duration
  int _breakDurationSeconds = 5 * 60; // 5 minutes break duration
  int _currentDuration = 25 * 60; // Initial work duration
  bool _isWorking = true; // Initial state: working
  bool _isTimerRunning = true; // Initial state: timer is running

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_isTimerRunning) {
          if (_currentDuration > 0) {
            _currentDuration--;
          } else {
            // Toggle between work and break durations
            if (_isWorking) {
              _currentDuration = _breakDurationSeconds;
              _isWorking = false;
            } else {
              _currentDuration = _workDurationSeconds;
              _isWorking = true;
            }
          }
        }
      });
    });
  }

  String _formatDuration(int durationSeconds) {
    int minutes = (durationSeconds / 60).truncate();
    int seconds = durationSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _toggleTimer() {
    setState(() {
      _isTimerRunning = !_isTimerRunning;
      if (_isTimerRunning) {
        _startTimer(); // Resume timer if it's running
      } else {
        _timer.cancel(); // Pause timer if it's stopped
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _timer.cancel(); // Stop the timer
      _currentDuration = _workDurationSeconds; // Reset timer to 25 minutes
      _isWorking = true; // Reset to work mode
      _isTimerRunning = false; // Pause the timer
    });
  }

  void _showSettingsDialog(BuildContext context) {
    int workMinutes = _workDurationSeconds ~/ 60;
    int breakMinutes = _breakDurationSeconds ~/ 60;

    int selectedWorkMinutes = workMinutes;
    int selectedBreakMinutes = breakMinutes;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Customize Pomodoro Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Work Duration (minutes): '),
              NumberPicker(
                value: selectedWorkMinutes,
                minValue: 1,
                maxValue: 60,
                onChanged: (value) {
                  setState(() {
                    selectedWorkMinutes = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              const Text('Break Duration (minutes): '),
              NumberPicker(
                value: selectedBreakMinutes,
                minValue: 1,
                maxValue: 60,
                onChanged: (value) {
                  setState(() {
                    selectedBreakMinutes = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _workDurationSeconds = selectedWorkMinutes * 60;
                  _breakDurationSeconds = selectedBreakMinutes * 60;
                  _resetTimer(); // Reset timer with new durations
                  Navigator.of(context).pop(); // Close dialog
                });
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  int _parseDuration(String input) {
    List<String> parts = input.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return hours * 3600 + minutes * 60 + seconds;
  }

  @override
  Widget build(BuildContext context) {
    String timerLabel = _isWorking ? 'Work' : 'Break';
    String formattedDuration = _formatDuration(_currentDuration);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context); // Show settings dialog
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              timerLabel,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              formattedDuration,
              style: const TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 24.0),
            _isTimerRunning
                ? ElevatedButton(
                    onPressed: _toggleTimer,
                    child: const Text('Stop'),
                  )
                : ElevatedButton(
                    onPressed: _toggleTimer,
                    child: const Text('Start'),
                  ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _resetTimer,
              child: const Text('Reset Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
