import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/Widgets/tasks_list_widget.dart';
import '../../core/shared/shared_preferences_manager.dart';
import '../../core/utility/task_utility.dart';
import '../../models/task_model.dart';

class TodoTasksScreen extends StatefulWidget {
  const TodoTasksScreen({super.key});

  @override
  State<TodoTasksScreen> createState() => _TodoTasksScreenState();
}

class _TodoTasksScreenState extends State<TodoTasksScreen> {
  List<TaskModel> _todoTasks = [];

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
        _todoTasks = tasksAfterDecode.map((element) => TaskModel.fromJson(element)).where((task) => !task.isDone).toList();
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
              "To Do Tasks",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 18,),
            Expanded(
              child: TasksListWidget(
                tasks: _todoTasks,
                onChanged: (value , index){
                  _updateIsDoneTask(value, index);
                },
                onEdit: (){
                  _loadTasks();
                },
                onDelete: _deleteTask,
                emptyMessage: "Tasks not found",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateIsDoneTask(bool? value , int index) async{
    setState(() {
      TaskUtility.updateIsDoneTaskInDatabase(value, index, _todoTasks);
    });
    _loadTasks(); //? Refresh Screen
  }

  void _deleteTask(int id)async{
    TaskUtility.deleteTaskFromDatabase(id);
    _loadTasks(); //? Refresh Screen
  }

}
