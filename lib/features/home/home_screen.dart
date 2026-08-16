import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/core/Widgets/custom_svg_picture_asset.dart';
import 'package:tasky/core/utility/task_utility.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';

import '../../core/constants/storage_key.dart';
import 'components/high_priority_tasks_widget.dart';
import 'components/sliver_tasks_list_widget.dart';
import '../../core/shared/shared_preferences_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String  _username = "";
  List<TaskModel> _tasks = [];
  int totalDoneTasks = 0;
  int totalTasks = 0;
  double percentOfDone = 0;

  String _motivationQuote = "";
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadTasks();
    _loadMotivationQuote();
    _loadImage();
  }

  void _loadUsername() {
    setState(() {
      _username = SharedPreferencesManager().getString(StorageKey.usernameKey) ?? 'Guest';
    });
  }

  void _loadMotivationQuote()  {
    setState(() {
      _motivationQuote =
          SharedPreferencesManager().getString(StorageKey.motivationQuoteKey) ??
              "One task at a time. One step closer.";
    });
  }
  void _loadTasks()  {
    final tasksBeforeDecode = SharedPreferencesManager().getString(StorageKey.tasksKey);
    if (tasksBeforeDecode != null) {
      final tasksAfterDecode = jsonDecode(tasksBeforeDecode) as List<dynamic>;
      setState(() {
        _tasks = tasksAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculateDoneTasksPercent();
      });
    }
  }
  void _loadImage(){
    setState(() {
      final String? imagePath = SharedPreferencesManager().getString(StorageKey.imageKey);
      if(imagePath != null){
        _profileImage = File(imagePath);
      }
    });
  }

  void _calculateDoneTasksPercent(){
    totalTasks = _tasks.length;
    totalDoneTasks = _tasks.where((task)=>task.isDone).length;
    percentOfDone = (totalTasks == 0) ? 0 : totalDoneTasks / totalTasks ;
  }
  @override
  Widget build(BuildContext context) {
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
                              backgroundImage: (_profileImage == null)
                                  ? AssetImage("assets/images/profile.png")
                                  : FileImage(_profileImage!),
                              radius: 25,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Evening , $_username',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                _motivationQuote,
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
                          totalDoneTasks: totalDoneTasks,
                          totalTasks: totalTasks,
                          percentOfDoneTasks: percentOfDone
                      ),
                      SizedBox(height: 10),
                      HighPriorityTasksWidget(
                        allTasks: _tasks,
                        onTap: (value, index) {
                          _updateIsDoneOfTask(index, value);
                        },
                        refresh: () {
                          _loadTasks();
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
                  tasks: _tasks,
                  onChanged: (value , index){
                    _updateIsDoneOfTask(index, value);
                  },
                  onDelete: _deleteTask,
                  onEdit: (){
                    _loadTasks();
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
              _loadTasks();
            }
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  void _updateIsDoneOfTask(int index, bool? value) async {
    setState(() {
      _tasks[index].isDone = value ?? false;
      _calculateDoneTasksPercent();
    });
    final tasksBeforeEncode = _tasks.map((task) => task.toMap()).toList();
    await SharedPreferencesManager().setString(
      StorageKey.tasksKey,
      jsonEncode(tasksBeforeEncode),
    );
  }

  void _deleteTask(int id)async{
    setState(() {
      TaskUtility.deleteTaskFromDatabase(id);
      _calculateDoneTasksPercent();
      _loadTasks();
    });
  }
}
