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

  // Method to toggle task completion status
  Task toggleCompletion() {
    return Task(
      id: this.id,
      title: this.title,
      description: this.description,
      dueDate: this.dueDate,
      priority: this.priority,
      notes: this.notes,
      isRecurring: this.isRecurring,
      isCompleted: !this.isCompleted, // Toggle isCompleted status
      recurringFrequency: this.recurringFrequency,
    );
  }
}
