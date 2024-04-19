import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?)? onCheckboxChanged; // Callback function for checkbox change

  TaskTile({
    required this.task,
    this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: onCheckboxChanged, // Pass the callback function
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/task-detail',
          arguments: task.id,
        );
      },
    );
  }
}
