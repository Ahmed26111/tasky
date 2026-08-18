import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/enums/task_status_enum.dart';
import '../../core/shared/shared_preferences_manager.dart';
import '../../core/utility/task_utility.dart';

class TasksController with ChangeNotifier{
  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> highPriorityTasks = [];

  void loadTasks(){
    final tasksBeforeDecode = SharedPreferencesManager().getString(StorageKey.tasksKey);
    if (tasksBeforeDecode != null) {
      final tasksAfterDecode = jsonDecode(tasksBeforeDecode) as List<dynamic>;
      tasks = tasksAfterDecode.map((element) => TaskModel.fromJson(element)).toList();
      todoTasks = tasks.where((task) => !task.isDone).toList();
      completedTasks = tasks.where((task) => task.isDone).toList();
      highPriorityTasks = tasks.where((task) => task.isHighPriority).toList();
    }
    notifyListeners();
  }

  void updateIsDoneOfTask(int index, bool? value , TaskStatus taskStatus){
    final List<TaskModel> updatedTasks = switch (taskStatus) {
      TaskStatus.todo => todoTasks,
      TaskStatus.completed => completedTasks,
      TaskStatus.highPriority => highPriorityTasks,
    };
    TaskUtility.updateIsDoneTaskInDatabase(value, index, updatedTasks);
    loadTasks(); //? refresh screen
  }

  void deleteTask(int id){
    TaskUtility.deleteTaskFromDatabase(id);
    loadTasks(); //? Refresh Screen
  }

}