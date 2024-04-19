import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'screens/task_form_screen.dart';
import 'models/task.dart';
import 'data/dummy_data.dart';

void main() {
  runApp(TaskifyApp());
}

class TaskifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TaskListScreen(tasks: dummyTasks),
        '/task-form': (context) => TaskFormScreen(),
      },
    );
  }
}
