import 'package:flutter/material.dart';
import 'package:tasky/core/Widgets/custom_check_box.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/models/task_model.dart';

class SliverTasksListWidget extends StatelessWidget {
  const SliverTasksListWidget({
    super.key,
    required this.tasks,
    required this.onChanged,
    this.emptyMessage = "No Tasks Yet!",
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final void Function(bool?, int) onChanged;
  final void Function(int) onDelete;
  final Function onEdit;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return (tasks.isNotEmpty)
        ? SliverPadding(
            padding: const EdgeInsets.only(bottom: 50),
            sliver: SliverList.separated(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  taskModel: tasks[index],
                  onChanged: (bool? value){
                    onChanged(value , index);
                  },
                  onDelete: onDelete,
                  onEdit: onEdit,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
            ),
          )
        : SliverToBoxAdapter(
          child: Center(
              child: Text(
                emptyMessage,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
        );
  }
}
