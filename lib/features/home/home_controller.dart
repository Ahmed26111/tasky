import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/shared/shared_preferences_manager.dart';
import '../../core/utility/task_utility.dart';
import '../../models/task_model.dart';

class HomeController with ChangeNotifier {
  String username = "";
  List<TaskModel> tasks = [];
  int totalDoneTasks = 0;
  int totalTasks = 0;
  double percentOfDone = 0;
  String motivationQuote = "";
  File? profileImage;

  void init() {
    loadUsername();
    loadTasks();
    loadMotivationQuote();
    loadImage();
  }

  void loadUsername() {
    username =
        SharedPreferencesManager().getString(StorageKey.usernameKey) ?? 'Guest';
    notifyListeners();
  }

  void loadMotivationQuote() {
    motivationQuote =
        SharedPreferencesManager().getString(StorageKey.motivationQuoteKey) ??
        "One task at a time. One step closer.";
    notifyListeners();
  }

  void loadTasks() {
    final tasksBeforeDecode = SharedPreferencesManager().getString(StorageKey.tasksKey);
    if (tasksBeforeDecode != null) {
      final tasksAfterDecode = jsonDecode(tasksBeforeDecode) as List<dynamic>;
      tasks = tasksAfterDecode.map((element) => TaskModel.fromJson(element)).toList();
      calculateDoneTasksPercent();
      notifyListeners();
    }
  }

  void loadImage() {
    final String? imagePath = SharedPreferencesManager().getString(StorageKey.imageKey);
    if (imagePath != null) {
      profileImage = File(imagePath);
    }
    notifyListeners();
  }

  void calculateDoneTasksPercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((task) => task.isDone).length;
    percentOfDone = (totalTasks == 0) ? 0 : totalDoneTasks / totalTasks;
  }

  void updateIsDoneOfTask(int index, bool? value) async {
    tasks[index].isDone = value ?? false;
    calculateDoneTasksPercent();
    final tasksBeforeEncode = tasks.map((task) => task.toMap()).toList();
    await SharedPreferencesManager().setString(
      StorageKey.tasksKey,
      jsonEncode(tasksBeforeEncode),
    );
    notifyListeners();
  }

  void deleteTask(int id)async{
    TaskUtility.deleteTaskFromDatabase(id);
    calculateDoneTasksPercent();
    loadTasks();
  }
}
