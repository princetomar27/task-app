import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  bool isLoading = true;

  List<Task> get tasks => _taskService.tasks;

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
      _taskService.addTask(Task(title: title));
      notifyListeners();
    }
  }

  void toggleTaskStatus(Task task) {
    _taskService.toggleTaskStatus(task);
    notifyListeners();
  }
}
