import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/core/Widgets/custom_svg_picture_asset.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import '../tasks/tasks_controller.dart';
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
              padding: EdgeInsets.all(AppSizes.pw16),
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
                                  padding: EdgeInsets.only(
                                    right: AppSizes.pw8,
                                    top: AppSizes.ph14,
                                    bottom: AppSizes.ph14,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: (image == null)
                                        ? AssetImage("assets/images/profile.png")
                                        : FileImage(image),
                                    radius: AppSizes.r25,
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
                        SizedBox(height: AppSizes.h16),
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
                              padding: EdgeInsets.only(
                                left: AppSizes.pw8,
                                top: AppSizes.ph4_5,
                                bottom: AppSizes.ph4_5,
                              ),
                              child: CustomSvgPictureAsset(
                                path: 'assets/images/waving_hand.svg',
                                width: AppSizes.w32,
                                height: AppSizes.h32,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.h20),
                        AchievedTasksWidget(),
                        SizedBox(height: AppSizes.h10),
                        HighPriorityTasksWidget(),
                        SizedBox(height: AppSizes.h10),
                        Text(
                          "My Tasks",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: AppSizes.h16),
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
              width: AppSizes.w168,
              height: AppSizes.h40,
              child: FloatingActionButton.extended(
                onPressed: () async{
                  final bool ? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()),
                  );
                  if(result != null && result){
                    contextController.read<TasksController>().loadTasks();
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
