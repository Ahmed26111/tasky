import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/Widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/shared/shared_preferences_manager.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Todo Dispose These Controllers
  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                          controller: _taskNameController,
                          hintText: 'Finish UI design for login screen',
                          title: "Task Name",
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your task';
                            }
                            return null;
                          },
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _taskDescriptionController,
                        hintText: 'Finish onboarding UI and hand off to devs by Thursday.',
                        title: "Task Description",
                        maxLines: 5,

                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Switch(
                            value: _isHighPriority,
                            onChanged: (bool value) {
                              setState(() {
                                _isHighPriority = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 10),
                child: FilledButton(
                  onPressed: () async {
                    if (_globalKey.currentState?.validate() ?? false) {

                      List<dynamic> tasks = [];

                      final tasksBeforeDecode = SharedPreferencesManager().getString(StorageKey.tasksKey);

                      if (tasksBeforeDecode != null) {
                        tasks = jsonDecode(tasksBeforeDecode) as List<dynamic>;
                      }

                      TaskModel newTask = TaskModel(
                        id: tasks.length + 1,
                        taskName: _taskNameController.text,
                        taskDescription: _taskDescriptionController.text,
                        isHighPriority: _isHighPriority,
                      );

                      tasks.add(newTask.toMap());

                      final String tasksEncode = jsonEncode(tasks);
                      await SharedPreferencesManager().setString(StorageKey.tasksKey, tasksEncode);

                      Navigator.pop(context , true);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8,),
                      Text("Add Task"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
