import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/Widgets/custom_check_box.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/models/task_model.dart';

import '../constants/storage_key.dart';
import '../enums/task_popup_menu_enum.dart';
import '../shared/shared_preferences_manager.dart';
import '../Widgets/custom_text_form_field.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key, required this.taskModel, required this.onChanged, required this.onDelete, required this.onEdit});

  final TaskModel taskModel;
  final void Function(bool?) onChanged;
  final void Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: ThemeController.isDarkThemeMode() ? null : Border.all(
          color: Color(0xFFD1DAD6)
        ),
      ),
      child: Row(
        children: [
          CustomCheckBox(
            value: taskModel.isDone,
            onChanged: onChanged,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.taskName,
                  style: (!taskModel.isDone)
                      ? Theme.of(context).textTheme.labelLarge
                      : Theme.of(context).textTheme.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (taskModel.taskDescription.isNotEmpty)
                  Text(
                    taskModel.taskDescription,
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskPopupMenuEnum>(
            icon: Icon(Icons.more_vert),
            iconColor: (taskModel.isDone)
                ? Theme.of(context).colorScheme.surfaceContainerHigh
                : Theme.of(context).colorScheme.surfaceContainerLow,
            onSelected: (value)async{
              switch(value){
                case TaskPopupMenuEnum.toggleDoneMark:
                    onChanged(!taskModel.isDone);
                case TaskPopupMenuEnum.edit:
                  final bool? result = await _showEditModalSheet(context , taskModel);
                  if(result ?? false){
                    onEdit();
                  }
                case TaskPopupMenuEnum.delete:
                  _showDeleteAlertDialog(context);
              }
            },
            itemBuilder: (context) => TaskPopupMenuEnum.values.map(
              (menuItem)=>PopupMenuItem<TaskPopupMenuEnum>(
                  value: menuItem,
                  child: Text(menuItem.name)
              )
            ).toList(),
          )
        ],
      ),
    );
  }

  void _showDeleteAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete task"),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Cancel")
            ),
            TextButton(
                onPressed: (){
                  onDelete(taskModel.id);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent
                ),
                child: Text("Delete"),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          contentTextStyle: Theme.of(context).textTheme.labelMedium,
          titleTextStyle: Theme.of(context).textTheme.displaySmall,
        )
    );
  }

  Future<bool?> _showEditModalSheet(BuildContext context , TaskModel model)async{
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController(text: model.taskName);
    final TextEditingController descriptionController = TextEditingController(text: model.taskDescription);
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
        context: context,
        isDismissible: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (context) => StatefulBuilder(
          builder: (context , setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Form(
                key: globalKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12 , left: 4 , right: 4),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: nameController,
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
                            controller: descriptionController,
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
                                value: isHighPriority,
                                onChanged: (bool value) {
                                  setState(() {
                                    isHighPriority = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 10),
                        child: FilledButton(
                          onPressed: () async {
                            if (globalKey.currentState?.validate() ?? false) {
                              List<TaskModel> tasks = [];

                              final tasksBeforeDecode = SharedPreferencesManager().getString(StorageKey.tasksKey);

                              if (tasksBeforeDecode != null) {
                                tasks = (jsonDecode(tasksBeforeDecode) as List<dynamic>).map(
                                    (item)=>TaskModel.fromJson(item)
                                ).toList();
                              }

                              TaskModel editedTask = TaskModel(
                                id: model.id,
                                taskName: nameController.text,
                                taskDescription: descriptionController.text,
                                isHighPriority: isHighPriority,
                                isDone: model.isDone
                              );

                              int indexOfEditedTask = tasks.indexWhere((task)=>task.id == model.id);

                              tasks[indexOfEditedTask] = editedTask;

                              final tasksBeforeEnCode = tasks.map((task)=>task.toMap()).toList();

                              final String tasksEncode = jsonEncode(tasksBeforeEnCode);

                              await SharedPreferencesManager().setString(StorageKey.tasksKey, tasksEncode);

                              Navigator.pop(context , true);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8,),
                              Text("Edit Task"),
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
        )
    );
  }
}
