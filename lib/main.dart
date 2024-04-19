import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'screens/task_form_screen.dart';
import 'screens/task_detail_screen.dart';
import 'data/dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TaskListScreen(),
        '/task-form': (ctx) => TaskFormScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/task-detail') {
          final taskId = settings.arguments as String;
          // Retrieve selected task based on taskId (e.g., from database)
          // For now, use dummyTasks from dummy_data.dart
          final selectedTask = dummyTasks.firstWhere((task) => task.id == taskId);
          return MaterialPageRoute(
            builder: (ctx) => TaskDetailScreen(selectedTask),
          );
        }
        return MaterialPageRoute(builder: (ctx) => TaskListScreen());
      },
    );
  }
}
