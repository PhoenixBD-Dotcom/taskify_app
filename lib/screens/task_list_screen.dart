import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'task_form_screen.dart'; // Import the task form screen

class TaskListScreen extends StatefulWidget {
  final List<Task> tasks;

  const TaskListScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task list'),
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (ctx, index) {
          final task = widget.tasks[index];

          return GestureDetector(
            onTap: () {
              _toggleTaskCompletion(index);
            },
            child: Dismissible(
              key: Key(task.id),
              direction: DismissDirection.startToEnd,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  _deleteTask(index);
                }
              },
              child: TaskTile(
                task: task,
                onDelete: () {
                  _deleteTask(index);
                },
                onTap: () {
                  _toggleTaskCompletion(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToTaskFormScreen(context); // Navigate to task form screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteTask(int index) {
    Task deletedTask = widget.tasks[index]; // Store the deleted task

    setState(() {
      widget.tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Undo deletion by restoring the deleted task
            setState(() {
              widget.tasks.insert(index, deletedTask);
            });
          },
        ),
      ),
    );
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      widget.tasks[index] = widget.tasks[index].copyWith(
        isCompleted: !widget.tasks[index].isCompleted,
      );
    });
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
