import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import '../../core/components/tasks_list_widget.dart';
import '../../core/enums/task_status_enum.dart';

class CompletedTasksScreen extends StatelessWidget{
  const CompletedTasksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.pw16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Completed Tasks",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: AppSizes.h18,),
            Expanded(
              child: Consumer<TasksController>(
                builder: (BuildContext context, TasksController controller, _) {
                  return TasksListWidget(
                    tasks: controller.completedTasks,
                    onChanged: (value , index) => controller.updateIsDoneOfTask(index , value , TaskStatus.completed),
                    onDelete: controller.deleteTask,
                    emptyMessage: "Tasks not found",
                    onEdit: controller.loadTasks,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
