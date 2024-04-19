import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  final List<Task> tasks;

  TaskListScreen({required this.tasks});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taskify'),
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (ctx, index) {
          final task = widget.tasks[index];
          return TaskTile(
            task: task,
            onCheckboxChanged: (value) {
              setState(() {
                // Toggle the isCompleted status of the task
                final updatedTask = task.copyWith(isCompleted: value ?? false);
                widget.tasks[index] = updatedTask;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToTaskFormScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToTaskFormScreen(BuildContext context) async {
    final newTask = await Navigator.of(context).pushNamed('/task-form');
    if (newTask != null && newTask is Task) {
      setState(() {
        widget.tasks.add(newTask);
      });
    }
  }
}
