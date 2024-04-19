import 'package:flutter/material.dart';

class PomodoroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      body: Center(
        child: Text(
          'Pomodoro Timer Screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
