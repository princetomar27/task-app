import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskService {
  final List<Task> tasks = [];
  static const String tasksKey = 'tasks_key';

  TaskService() {
    loadTasks();
  }

  // Save tasks to local storage
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    prefs.setString(tasksKey, json.encode(tasksJson));
  }

  // Load tasks from local storage
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(tasksKey);
    if (tasksString != null) {
      final tasksJson = json.decode(tasksString) as List;
      tasks.clear();
      tasks.addAll(tasksJson.map((json) => Task.fromJson(json)).toList());
    }
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
  }

  void toggleTaskStatus(Task task) {
    task.isComplete = !task.isComplete;
    saveTasks();
  }
}
