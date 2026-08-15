import 'package:flutter/material.dart';
import 'package:tasky/core/Widgets/custom_check_box.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/models/task_model.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({
    super.key,
    required this.tasks,
    required this.onChanged,
    this.emptyMessage = "No Tasks Yet!",
    this.isShrinkWrap = false,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final void Function(bool?, int) onChanged;
  final void Function(int) onDelete;
  final Function onEdit;
  final String emptyMessage;
  final bool isShrinkWrap;

  @override
  Widget build(BuildContext context) {
    return (tasks.isNotEmpty)
        ? ListView.separated(
            shrinkWrap: isShrinkWrap,
            physics: (isShrinkWrap) ? NeverScrollableScrollPhysics() : null,
            itemCount: tasks.length,
            padding: const EdgeInsets.only(bottom: 45),
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
          )
        : Center(
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          );
  }
}
