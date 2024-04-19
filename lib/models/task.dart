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
  final bool isCompleted;
  final String? recurringFrequency; // Add recurringFrequency property

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.notes,
    required this.isRecurring,
    required this.isCompleted,
    this.recurringFrequency, // Initialize recurringFrequency property
  });

  // Method to create a new Task instance with updated properties
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    TaskPriority? priority,
    List<String>? notes,
    bool? isRecurring,
    bool? isCompleted,
    String? recurringFrequency, // Include recurringFrequency in copyWith method
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      isRecurring: isRecurring ?? this.isRecurring,
      isCompleted: isCompleted ?? this.isCompleted,
      recurringFrequency: recurringFrequency ?? this.recurringFrequency,
    );
  }
}
