import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
              padding: EdgeInsets.all(16.0).r,
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
                                    right: 8.0.w,
                                    top: 14.h,
                                    bottom: 14.h,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: (image == null)
                                        ? AssetImage("assets/images/profile.png")
                                        : FileImage(image),
                                    radius: 25.r,
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
                        SizedBox(height: 16.h),
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
                                left: 8.0.w,
                                top: 4.5.h,
                                bottom: 4.5.h,
                              ),
                              child: CustomSvgPictureAsset(
                                path: 'assets/images/waving_hand.svg',
                                width: 32.w,
                                height: 32.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        AchievedTasksWidget(),
                        SizedBox(height: 10.h),
                        HighPriorityTasksWidget(),
                        SizedBox(height: 10.h),
                        Text(
                          "My Tasks",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 16.h),
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
              width: 168.w,
              height: 40.h,
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
