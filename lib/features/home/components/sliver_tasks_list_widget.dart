import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

import '../../../core/enums/task_status_enum.dart';

class SliverTasksListWidget extends StatelessWidget {
  const SliverTasksListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        return (controller.tasks.isNotEmpty)
                ? SliverPadding(
                    padding: EdgeInsets.only(bottom: AppSizes.ph50),
                    sliver: SliverList.separated(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskItemWidget(
                          taskModel: controller.tasks[index],
                          onChanged: (bool? value) {
                            controller.updateIsDoneOfTask(index, value ,TaskStatus.all);
                          },
                          onDelete: controller.deleteTask,
                          onEdit: controller.loadTasks,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: AppSizes.h8),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No Tasks Yet!",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  );
      },
    );
  }
}
