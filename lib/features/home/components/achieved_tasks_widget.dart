import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        return Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20).r,
              side: ThemeController.isDarkThemeMode() ? BorderSide.none : BorderSide(color: Color(0xFFD1DAD6))
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            tileColor: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20).r),
            title: Text("Achieved Tasks"),
            titleTextStyle: Theme.of(context).textTheme.labelLarge,
            subtitle: Text("${controller.totalDoneTasks} Out of ${controller.totalTasks} Done"),
            subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
            trailing: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: -pi / 2,
                  child: SizedBox(
                    width: 48.w,
                    height: 48.h,
                    child: CircularProgressIndicator(value: controller.percentOfDone),
                  ),
                ),
                Text(
                  "${(controller.percentOfDone * 100).toInt()}%",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
