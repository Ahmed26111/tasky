import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/Widgets/custom_check_box.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/models/task_model.dart';

class SliverTasksListWidget extends StatelessWidget {
  const SliverTasksListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        return (controller.tasks.isNotEmpty)
                ? SliverPadding(
                    padding: const EdgeInsets.only(bottom: 50),
                    sliver: SliverList.separated(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskItemWidget(
                          taskModel: controller.tasks[index],
                          onChanged: (bool? value) {
                            controller.updateIsDoneOfTask(index, value);
                          },
                          onDelete: controller.deleteTask,
                          onEdit: controller.loadTasks,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
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
