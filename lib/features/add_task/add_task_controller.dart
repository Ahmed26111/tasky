import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/shared/shared_preferences_manager.dart';
import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier{
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (globalKey.currentState?.validate() ?? false) {

      List<dynamic> tasks = [];

      final tasksBeforeDecode = SharedPreferencesManager().getString(StorageKey.tasksKey);

      if (tasksBeforeDecode != null) {
        tasks = jsonDecode(tasksBeforeDecode) as List<dynamic>;
      }

      TaskModel newTask = TaskModel(
        id: tasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      tasks.add(newTask.toMap());

      final String tasksEncode = jsonEncode(tasks);
      await SharedPreferencesManager().setString(StorageKey.tasksKey, tasksEncode);

      Navigator.pop(context , true);
    }
  }

  void changeIsHighPriority(bool value){
    isHighPriority = value;
    notifyListeners();
  }

}