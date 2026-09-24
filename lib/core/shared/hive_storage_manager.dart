import 'package:hive_ce_flutter/adapters.dart';
import '../../models/task_model.dart';

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._internal();

  HiveStorageManager._internal();

  factory HiveStorageManager(){
    return _instance;
  }

  late final Box<TaskModel> _tasksBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _tasksBox =  await Hive.openBox<TaskModel>("tasks");
  }

  Future<void> saveTask(List<TaskModel> tasks) async {
    await _tasksBox.clear();
    await _tasksBox.addAll(tasks);
  }

  List<TaskModel> loadTasks(){
    return _tasksBox.values.toList();
  }

  Future<void> deleteTasks()async{
    await _tasksBox.clear();
  }

}