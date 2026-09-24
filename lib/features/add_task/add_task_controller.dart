import 'package:flutter/material.dart';
import 'package:tasky/core/shared/hive_storage_manager.dart';
import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier{
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (globalKey.currentState?.validate() ?? false) {
      List<TaskModel> tasks = [];
      tasks = HiveStorageManager().loadTasks();
      TaskModel newTask = TaskModel(
        id: tasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );
      tasks.add(newTask);
      await HiveStorageManager().saveTask(tasks);
      Navigator.pop(context , true);
    }
  }

  void changeIsHighPriority(bool value){
    isHighPriority = value;
    notifyListeners();
  }

}