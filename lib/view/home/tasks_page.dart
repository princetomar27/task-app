import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../viewmodels/task_view_model.dart';
import 'widgets/task_item.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
      ),
      body: taskViewModel.isLoading
          ? Center(
              child: Lottie.asset('assets/loading.json'),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: taskViewModel.selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            taskViewModel.setFilterDate(selectedDate);
                          }
                        },
                      ),
                      Text(
                        "Selected Date: ${DateFormat('yyyy-MM-dd').format(taskViewModel.selectedDate)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: size.width * 0.05),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            DateTime selectedDate = taskViewModel.selectedDate;
                            await taskViewModel
                                .uploadTasksForDate(selectedDate);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Tasks uploaded successfully")),
                            );
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("Error uploading tasks: $error")),
                            );
                          }
                        },
                        child: const Text("Upload Tasks"),
                      ),
                    ],
                  ),
                ),
                taskViewModel.tasks.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/empty.json'),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            "No Tasks Yet!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: taskViewModel.tasks.length,
                          itemBuilder: (context, index) {
                            Task task = taskViewModel.tasks[index];
                            Color tileColor = generateRandomLightColor();
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: tileColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TaskItem(
                                task: task,
                                onToggle: (_) {
                                  taskViewModel.toggleTaskStatus(task);
                                },
                                onDelete: () {
                                  taskViewModel.deleteTask(task.id);
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, taskViewModel),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskViewModel taskViewModel) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: "Task Title"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                taskViewModel.addTask(titleController.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Color generateRandomLightColor() {
    Random random = Random();
    int red = 160 + random.nextInt(55);
    int green = 160 + random.nextInt(55);
    int blue = 160 + random.nextInt(55);
    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
