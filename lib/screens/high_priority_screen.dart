import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/utility/task_utility.dart';

import '../core/Widgets/tasks_list_widget.dart';
import '../core/shared/shared_preferences_manager.dart';
import '../models/task_model.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> _highPriorityTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final tasksBeforeDecode = SharedPreferencesManager().getString("tasks");
    if (tasksBeforeDecode != null) {
      final tasksAfterDecode = jsonDecode(tasksBeforeDecode) as List<dynamic>;
      setState(() {
        _highPriorityTasks = tasksAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((task) => (task.isHighPriority))
            .toList();
      });
    }
  }

  void _updateIsDoneOfTask(int index, bool? value) async {
    setState(() {
      TaskUtility.updateIsDoneTaskInDatabase(value, index, _highPriorityTasks);
    });
    _loadTasks(); //? refresh screen
  }

  void _deleteTask(int id) async {
    TaskUtility.deleteTaskFromDatabase(id);
    _loadTasks(); //? Refresh Screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TasksListWidget(
          tasks: _highPriorityTasks,
          onChanged: (value, index) {
            _updateIsDoneOfTask(index, value);
          },
          onEdit: () {
            _loadTasks();
          },
          onDelete: _deleteTask,
        ),
      ),
    );
  }
}
