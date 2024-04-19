import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'screens/pomodoro_screen.dart';
import 'screens/stopwatch_screen.dart';
import 'screens/more_screen.dart';
import 'models/task.dart';
import 'data/dummy_data.dart';

void main() {
  runApp(TaskifyApp());
}

class TaskifyApp extends StatefulWidget {
  @override
  _TaskifyAppState createState() => _TaskifyAppState();
}

class _TaskifyAppState extends State<TaskifyApp> {
  int _selectedIndex = 0; // Index of the selected tab

  // List of screens corresponding to each bottom navigation bar item
  final List<Widget> _screens = [
    TaskListScreen(tasks: dummyTasks),
    PomodoroScreen(),
    StopwatchScreen(),
    MoreScreen(),
  ];

  // Handle bottom navigation item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Taskify', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: _screens[_selectedIndex], // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue, // Set selected icon color to blue
          unselectedItemColor: Colors.blueGrey[600], // Set unselected icon color to blueGrey[600]
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Pomodoro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch),
              label: 'Stopwatch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
