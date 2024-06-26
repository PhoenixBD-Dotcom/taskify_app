import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _dueDateTime; // Updated to store both date and time
  TaskPriority _priority = TaskPriority.low;
  final List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dueDateTime = DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDueDateTime(context);
                    },
                    child: const Text('Date & Time'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Text('$_dueDateTime'),
              ],
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<TaskPriority>(
              value: _priority,
              items: TaskPriority.values.map((priority) {
                return DropdownMenuItem<TaskPriority>(
                  value: priority,
                  child: Text(priority.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveTask(context);
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDueDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dueDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          _dueDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveTask(BuildContext context) {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter title and description')),
      );
      return;
    }

    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      dueDate: _dueDateTime,
      priority: _priority,
      notes: _notes,
      isRecurring: false,
      isCompleted: false,
    );

    Navigator.of(context).pop(newTask);
  }
}
