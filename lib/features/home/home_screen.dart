import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/core/Widgets/custom_svg_picture_asset.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'components/high_priority_tasks_widget.dart';
import 'components/sliver_tasks_list_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (context , valueController , child) {
          final HomeController controller = context.read<HomeController>();
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                    top: 14,
                                    bottom: 14,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: (valueController.profileImage == null)
                                        ? AssetImage("assets/images/profile.png")
                                        : FileImage(valueController.profileImage!),
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Good Evening , ${valueController.username}',
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    Text(
                                      valueController.motivationQuote,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Yuhuu ,Your work Is',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Row(
                              children: [
                                Text(
                                  'almost done !',
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 4.5,
                                    bottom: 4.5,
                                  ),
                                  child: CustomSvgPictureAsset(
                                    path: 'assets/images/waving_hand.svg',
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            AchievedTasksWidget(
                                totalDoneTasks: valueController.totalDoneTasks,
                                totalTasks: valueController.totalTasks,
                                percentOfDoneTasks: valueController.percentOfDone
                            ),
                            SizedBox(height: 10),
                            HighPriorityTasksWidget(
                              allTasks: valueController.tasks,
                              onTap: (value, index) {
                                controller.updateIsDoneOfTask(index, value);
                              },
                              refresh: () {
                                controller.loadTasks();
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              "My Tasks",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                      SliverTasksListWidget(
                        tasks: valueController.tasks,
                        onChanged: (value , index){
                          controller.updateIsDoneOfTask(index, value);
                        },
                        onDelete: controller.deleteTask,
                        onEdit: (){
                          controller.loadTasks();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: SizedBox(
              width: 168,
              height: 40,
              child: FloatingActionButton.extended(
                onPressed: () async{
                  final bool ? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()),
                  );
                  if(result != null && result){
                    controller.loadTasks();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
              ),
            ),
          );
        }
      ),
    );
  }
}
