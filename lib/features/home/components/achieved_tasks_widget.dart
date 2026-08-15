import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,
    required this.totalDoneTasks,
    required this.totalTasks,
    required this.percentOfDoneTasks,
  });

  final int totalDoneTasks;
  final int totalTasks;
  final double percentOfDoneTasks;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: ThemeController.isDarkThemeMode() ? BorderSide.none : BorderSide(color: Color(0xFFD1DAD6))
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Achieved Tasks"),
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
        subtitle: Text("$totalDoneTasks Out of $totalTasks Done"),
        subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -pi / 2,
              child: SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(value: percentOfDoneTasks),
              ),
            ),
            Text(
              "${(percentOfDoneTasks * 100).toInt()}%",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
