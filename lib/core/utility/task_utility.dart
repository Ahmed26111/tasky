import 'dart:convert';

import '../../models/task_model.dart';
import '../constants/storage_key.dart';
import '../shared/shared_preferences_manager.dart';

abstract class TaskUtility{
  static void deleteTaskFromDatabase(int id) async{
    final allData = SharedPreferencesManager().getString(StorageKey.tasksKey);
    if(allData != null){
      final allDataList = (jsonDecode(allData) as List).map((data)=>TaskModel.fromJson(data)).toList();
      allDataList.removeWhere((task)=>task.id==id);
      final allDataBeforeEncode = allDataList.map((task) => task.toMap()).toList();
      await SharedPreferencesManager().setString(
        StorageKey.tasksKey, jsonEncode(allDataBeforeEncode),
      );
    }
  }

  static void updateIsDoneTaskInDatabase(bool? value , int index , List<TaskModel> tasks)async{
    tasks[index].isDone = value ?? false;
    final allData = SharedPreferencesManager().getString(StorageKey.tasksKey);
    if(allData != null){
      final allDataList = (jsonDecode(allData) as List).map((data)=>TaskModel.fromJson(data)).toList();
      final int newIndex = allDataList.indexWhere((data)=>(data.id == tasks[index].id));
      if(newIndex != -1){
        allDataList[newIndex] = tasks[index];
        final allDataBeforeEncode = allDataList.map((task) => task.toMap()).toList();
        await SharedPreferencesManager().setString(
          StorageKey.tasksKey, jsonEncode(allDataBeforeEncode),
        );
      }
    }
  }

}