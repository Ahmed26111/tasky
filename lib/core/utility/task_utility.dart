import 'package:tasky/core/shared/hive_storage_manager.dart';
import '../../models/task_model.dart';

abstract class TaskUtility {
  static Future<void> deleteTaskFromDatabase(int id) async {
    final allDataList = HiveStorageManager().loadTasks();
    allDataList.removeWhere((task) => task.id == id);
    await HiveStorageManager().saveTask(allDataList);
  }

  static Future<void> updateIsDoneTaskInDatabase(bool? value, int index, List<TaskModel> tasks) async {
    tasks[index].isDone = value ?? false;
    final allDataList = HiveStorageManager().loadTasks();
    final int newIndex = allDataList.indexWhere(
      (data) => (data.id == tasks[index].id),
    );
    if (newIndex != -1) {
      allDataList[newIndex] = tasks[index];
      await HiveStorageManager().saveTask(allDataList);
    }
  }
}
