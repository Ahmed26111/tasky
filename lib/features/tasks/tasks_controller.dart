import 'package:flutter/material.dart';
import 'package:tasky/core/shared/hive_storage_manager.dart';
import 'package:tasky/models/task_model.dart';
import '../../core/enums/task_status_enum.dart';
import '../../core/utility/task_utility.dart';

class TasksController with ChangeNotifier {
  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> highPriorityTasks = [];
  int totalDoneTasks = 0;
  int totalTasks = 0;
  double percentOfDone = 0;

  void loadTasks() {
    tasks = HiveStorageManager().loadTasks();
    todoTasks = tasks.where((task) => !task.isDone).toList();
    completedTasks = tasks.where((task) => task.isDone).toList();
    highPriorityTasks = tasks.where((task) => task.isHighPriority).toList();
    _calculateDoneTasksPercent();
    notifyListeners();
  }

  Future<void> updateIsDoneOfTask(int index, bool? value, TaskStatus taskStatus) async {
    final List<TaskModel> updatedTasks = switch (taskStatus) {
      TaskStatus.todo => todoTasks,
      TaskStatus.completed => completedTasks,
      TaskStatus.highPriority => highPriorityTasks,
      TaskStatus.all => tasks,
    };
    await TaskUtility.updateIsDoneTaskInDatabase(value, index, updatedTasks);
    loadTasks(); //? refresh screen
  }

  Future<void> deleteTask(int id) async {
    await TaskUtility.deleteTaskFromDatabase(id);
    loadTasks(); //? Refresh Screen
  }

  void _calculateDoneTasksPercent() {
    totalTasks = tasks.length;
    totalDoneTasks = completedTasks.length;
    percentOfDone = (totalTasks == 0) ? 0 : totalDoneTasks / totalTasks;
  }
}
