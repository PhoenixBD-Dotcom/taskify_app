import '../models/task.dart';

List<Task> dummyTasks = [
  Task(
    id: '1',
    title: 'Complete Project Proposal',
    description: 'Finish and submit the project proposal by Friday.',
    dueDate: DateTime.now().add(Duration(days: 4)),
    priority: TaskPriority.high,
    notes: ['Prepare presentation slides', 'Gather project requirements'],
    isRecurring: false,
  ),
  Task(
    id: '2',
    title: 'Meeting with Team',
    description: 'Discuss project roadmap with the team on Tuesday.',
    dueDate: DateTime.now().add(Duration(days: 2)),
    priority: TaskPriority.medium,
    notes: ['Prepare meeting agenda', 'Review project milestones'],
    isRecurring: false,
  ),
  Task(
    id: '3',
    title: 'Daily Standup',
    description: 'Attend daily standup meeting at 10:00 AM.',
    dueDate: DateTime.now(),
    priority: TaskPriority.low,
    notes: ['Update team on progress', 'Highlight any blockers'],
    isRecurring: true,
    recurringFrequency: 'daily',
  ),
  // Add more dummy tasks as needed
];
