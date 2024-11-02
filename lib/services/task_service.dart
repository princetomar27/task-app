import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskService {
  final List<Task> tasks = [];
  static const String tasksKey = 'tasks_key';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TaskService() {
    loadTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    prefs.setString(tasksKey, json.encode(tasksJson));
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(tasksKey);
    if (tasksString != null) {
      final tasksJson = json.decode(tasksString) as List;
      tasks.clear();
      tasks.addAll(tasksJson.map((json) => Task.fromJson(json)).toList());
    }
  }

  Future<void> saveTasksForDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksForDate =
        tasks.where((task) => isSameDate(task.date, date)).toList();
    final tasksJson = tasksForDate.map((task) => task.toJson()).toList();
    prefs.setString(
        "${tasksKey}_${date.toIso8601String()}", json.encode(tasksJson));
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> uploadTasks(DateTime date, List<Task> tasks) async {
    try {
      CollectionReference tasksRef = _firestore.collection('tasks');

      // Normalize the date for comparison (remove time component)
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);

      // Delete existing tasks for the specified date from Firestore
      QuerySnapshot snapshot = await tasksRef
          .where('date', isEqualTo: normalizedDate.toIso8601String())
          .get();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      // Upload new tasks to Firestore
      for (Task task in tasks) {
        // Ensure to set the date for the task if it needs to be included
        await tasksRef
            .add(task.toJson()..['date'] = normalizedDate.toIso8601String());
      }

      print("Tasks uploaded successfully for date $date.");
    } catch (e) {
      print("Error uploading tasks: $e");
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

  Future<void> deleteTask(String taskId) async {
    tasks.removeWhere((task) => task.id == taskId);
    await saveTasks();
    print("Task with ID: $taskId deleted successfully.");
  }
}
