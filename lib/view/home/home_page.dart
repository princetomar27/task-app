import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constant.dart';
import '../../viewmodels/task_view_model.dart';
import 'widgets/task_item.dart';

class HomePage extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.appTitle)),
        body: Consumer<TaskViewModel>(
          builder: (context, taskViewModel, child) {
            if (taskViewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: taskController,
                          decoration: const InputDecoration(
                              labelText: AppStrings.newTaskHint),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        onPressed: () {
                          taskViewModel.addTask(taskController.text);
                          taskController.clear();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: taskViewModel.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskViewModel.tasks[index];
                      var tileColor = generateRandomLightColor();
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: tileColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: TaskItem(
                            task: task,
                            onToggle: taskViewModel.toggleTaskStatus),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Generate random color for tile colors
  Color generateRandomLightColor() {
    Random random = Random();
    int red = 180 + random.nextInt(55);
    int green = 180 + random.nextInt(55);
    int blue = 180 + random.nextInt(55);
    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
