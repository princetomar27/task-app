import 'package:flutter/material.dart';

import '../../../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) onToggle;

  const TaskItem({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: TextStyle(
              decoration: task.isComplete ? TextDecoration.lineThrough : null,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            task.isComplete ? 'Completed' : 'Pending',
            style: TextStyle(
              color: task.isComplete ? Colors.white : Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
      trailing: Checkbox(
        value: task.isComplete,
        onChanged: (_) => onToggle(task),
      ),
    );
  }
}
