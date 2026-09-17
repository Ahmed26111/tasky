import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._internal();

  FileStorageManager._internal();

  factory FileStorageManager(){
    return _instance;
  }

  late final Directory _appDirectory;
  late final File _tasksFile;

  Future<void> init() async {
    _appDirectory = await getApplicationDocumentsDirectory();
    _tasksFile = File("${_appDirectory.path}/tasks.json");
  }

  Future<void> saveTask(List tasks) async {
    await _tasksFile.writeAsString(jsonEncode(tasks));
  }

  Future<List> loadTasks() async {
    if (await _tasksFile.exists()) {
      final String contents = await _tasksFile.readAsString();
      return jsonDecode(contents) as List;
    } else {
      return [];
    }
  }

}