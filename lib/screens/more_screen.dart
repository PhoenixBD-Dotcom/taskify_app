import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: Center(
        child: Text(
          'More Screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
