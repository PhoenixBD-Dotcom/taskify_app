import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onTap; // Callback to handle tapping the task tile

  TaskTile({
    required this.task,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          color: task.isCompleted ? Colors.grey : Colors.black,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description),
          SizedBox(height: 8.0),
          Text(
            'Due: ${_formatDateTime(task.dueDate)}',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
      onTap: onTap, // Handle tap on the task tile
    );
  }

  String _formatDateTime(DateTime dateTime) {
    // Format date and time as a string
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
