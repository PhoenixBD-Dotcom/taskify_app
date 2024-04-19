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
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.notes,
    required this.isRecurring,
    required this.isCompleted,
    this.recurringFrequency,
  });

  Task copyWith({
    bool? isCompleted,
  }) {
    return Task(
      id: this.id,
      title: this.title,
      description: this.description,
      dueDate: this.dueDate,
      priority: this.priority,
      notes: this.notes,
      isRecurring: this.isRecurring,
      isCompleted: isCompleted ?? this.isCompleted,
      recurringFrequency: this.recurringFrequency,
    );
  }
}
