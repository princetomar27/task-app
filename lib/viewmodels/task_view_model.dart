import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../services/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();

  List<Task> get tasks => _taskService.tasks
      .where((task) => isSameDate(task.date, selectedDate))
      .toList();

  TaskViewModel() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await _taskService.loadTasks();
    isLoading = false;
    notifyListeners();
  }

  void addTask(String title) {
    if (title.isNotEmpty) {
      _taskService
          .addTask(Task(id: Uuid().v4(), title: title, date: selectedDate));
      notifyListeners();
    }
  }

  void toggleTaskStatus(Task task) {
    _taskService.toggleTaskStatus(task);
    notifyListeners();
  }

  void setFilterDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> uploadTasksForDate(DateTime date) async {
    await _taskService.uploadTasks(date, tasks);
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void deleteTask(String taskId) {
    _taskService.deleteTask(taskId).then((_) {
      _loadTasks();
      notifyListeners();
    });
  }
}
