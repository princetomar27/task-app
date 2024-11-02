import 'package:flutter/material.dart';

import '../../../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) onToggle;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

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
          Container(
            height: 25,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              task.isComplete ? 'Completed' : 'Pending',
              style: TextStyle(
                color: task.isComplete
                    ? Colors.green.shade700
                    : Colors.red.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: task.isComplete,
            onChanged: (_) => onToggle(task),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
