import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/Widgets/custom_check_box.dart';
import 'package:tasky/core/enums/task_status_enum.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        final List<TaskModel> taskPriority = controller.highPriorityTasks.reversed.toList();
        return Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0).r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 1. Task List Section (Wrapped in Expanded to prevent exceptions)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Text(
                          "High Priority Tasks",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      (taskPriority.isNotEmpty)
                          ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (taskPriority.length > 4) ? 4 : taskPriority.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              CustomCheckBox(
                                value: taskPriority[index].isDone,
                                onChanged: (bool? value) {
                                  int indexOfAllTask = controller.tasks.indexWhere((task) => task.id == taskPriority[index].id);
                                  controller.updateIsDoneOfTask(indexOfAllTask, value , TaskStatus.all);
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      taskPriority[index].taskName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: (!taskPriority[index].isDone)
                                          ?Theme.of(context).textTheme.labelLarge
                                          :Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    if (taskPriority[index].taskDescription
                                        .isNotEmpty)
                                      Text(
                                        taskPriority[index].taskDescription,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.labelSmall,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )
                          : Text(
                        "There is no tasks yet!",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),

                // 2. The Icon (Added on the right side)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: IconButton.outlined(
                    onPressed: () async{
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HighPriorityScreen()
                          )
                      );
                      controller.loadTasks();
                    },
                    style: ThemeController.isDarkThemeMode()
                        ? IconButton.styleFrom(
                      backgroundColor: const Color(0xFF282828),
                      foregroundColor: const Color(0xFFC6C6C6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      side: BorderSide(
                        color: Color(0xFF6E6E6E),
                      ),
                    )
                        : IconButton.styleFrom(
                      backgroundColor: const Color(0xFFFFFFFF),
                      foregroundColor: const Color(0xFF6A6A6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      side: BorderSide(
                          color: const Color(0xFFD1DAD6),
                          width: 1
                      ),
                    ),
                    icon: Icon(Icons.arrow_upward), //! Temporary cause image is not opened
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}