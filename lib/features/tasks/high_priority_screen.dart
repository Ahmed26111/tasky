import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/enums/task_status_enum.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import '../../core/components/tasks_list_widget.dart';

class HighPriorityScreen extends StatelessWidget{
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<TasksController>(
          builder: (BuildContext context, TasksController controller,_) {
            return TasksListWidget(
              tasks: controller.highPriorityTasks,
              onChanged: (value, index) => controller.updateIsDoneOfTask(index, value , TaskStatus.highPriority),
              onEdit:controller.loadTasks,
              onDelete: controller.deleteTask,
            );
          },
        ),
      ),
    );
  }
}
