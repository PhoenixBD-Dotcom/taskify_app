import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  final List<Task> tasks;

  TaskListScreen({required this.tasks});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void _deleteTask(Task task) {
    setState(() {
      widget.tasks.remove(task);
    });
  }

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
                // Toggle the task's completion status
                widget.tasks[index] = task.toggleCompletion();
              });
            },
            onDelete: () {
              _deleteTask(task); // Pass task to delete
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
