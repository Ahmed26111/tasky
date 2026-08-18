import 'dart:io';

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
      child: Scaffold(
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
                            Selector<HomeController , File?>(
                              selector: (BuildContext context, HomeController controller) => controller.profileImage,
                              builder: (BuildContext context, File? image, Widget? child) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                    top: 14,
                                    bottom: 14,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: (image == null)
                                        ? AssetImage("assets/images/profile.png")
                                        : FileImage(image),
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                  ),
                                );
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Selector<HomeController , String>(
                                  selector: (BuildContext context, HomeController controller) => controller.username,
                                  builder: (BuildContext context, String username, Widget? child) {
                                    return Text(
                                      'Good Evening , $username',
                                      style: Theme.of(context).textTheme.labelLarge,
                                    );
                                  },
                                ),
                                Selector<HomeController , String>(
                                  selector: (BuildContext context, HomeController controller) => controller.motivationQuote,
                                  builder: (BuildContext context, String motivationQuote, Widget? child) {
                                    return Text(
                                      motivationQuote,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    );
                                  },
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
                        AchievedTasksWidget(),
                        SizedBox(height: 10),
                        HighPriorityTasksWidget(),
                        SizedBox(height: 10),
                        Text(
                          "My Tasks",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SliverTasksListWidget(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext contextController) {
            return SizedBox(
              width: 168,
              height: 40,
              child: FloatingActionButton.extended(
                onPressed: () async{
                  final bool ? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()),
                  );
                  if(result != null && result){
                    contextController.read<HomeController>().loadTasks();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}
