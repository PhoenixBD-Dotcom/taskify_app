import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleDone;

  TaskTile({required this.task, required this.onToggleDone});

  @override
  Widget build(BuildContext context) {
    bool isDone = task.isCompleted;

    return ListTile(
      title: Text(
        task.title,
        style: isDone ? TextStyle(decoration: TextDecoration.lineThrough) : null,
      ),
      subtitle: Text(task.description),
      trailing: GestureDetector(
        onTap: onToggleDone,
        child: isDone ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
      ),
      onLongPress: () {
        // Optional: Implement additional actions for long-press if needed
      },
    );
  }
}
