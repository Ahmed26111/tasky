import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/Widgets/custom_text_form_field.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/add_task/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final AddTaskController controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.pw16,
              vertical: AppSizes.ph8,
            ),
            child: Form(
              key: controller.globalKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: controller.taskNameController,
                            hintText: 'Finish UI design for login screen',
                            title: "Task Name",
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your task';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppSizes.h20),
                          CustomTextFormField(
                            controller: controller.taskDescriptionController,
                            hintText:
                                'Finish onboarding UI and hand off to devs by Thursday.',
                            title: "Task Description",
                            maxLines: 5,
                          ),
                          SizedBox(height: AppSizes.h20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "High Priority",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Selector<AddTaskController , bool>(
                                selector: (_ , controller)=>controller.isHighPriority,
                                builder: (context , isHighPriority , _){
                                  return Switch(
                                    value: isHighPriority,
                                    onChanged: controller.changeIsHighPriority,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.pw6,
                      vertical: AppSizes.ph10,
                    ),
                    child: FilledButton(
                      onPressed: () async {
                        controller.addTask(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: AppSizes.w8),
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
      },
    );
  }
}
