import 'package:flutter/material.dart';

class StopwatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Text(
          'Stopwatch Screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
