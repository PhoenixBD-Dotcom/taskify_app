import 'package:flutter/foundation.dart';

enum TaskPriority {
  low,
  medium,
  high,
}

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  final List<String> notes;
  final bool isRecurring;
  final String? recurringFrequency;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.notes,
    required this.isRecurring,
    this.recurringFrequency,
  });
}
