import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/Widgets/tasks_list_widget.dart';
import '../core/shared/shared_preferences_manager.dart';
import '../core/utility/task_utility.dart';
import '../models/task_model.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> _completedTasks = [];

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
        _completedTasks = tasksAfterDecode.map((element) => TaskModel.fromJson(element)).where((task) => task.isDone).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Completed Tasks",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 18,),
            Expanded(
              child: TasksListWidget(
                tasks: _completedTasks,
                onChanged: (value , index){
                  _updateIsDoneTask(value, index);
                },
                onDelete: _deleteTask,
                emptyMessage: "Tasks not found",
                onEdit: (){
                  _loadTasks();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateIsDoneTask(bool? value, int index)async{
    setState(() {
      TaskUtility.updateIsDoneTaskInDatabase(value, index, _completedTasks);
    });
    _loadTasks(); //? Refresh Screen
  }

  void _deleteTask(int id)async{
    TaskUtility.deleteTaskFromDatabase(id);
    _loadTasks(); //? Refresh Screen
  }

}
