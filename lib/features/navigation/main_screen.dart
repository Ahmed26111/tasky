import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/Widgets/custom_svg_picture_asset.dart';
import 'package:tasky/features/tasks/completed_tasks_screen.dart';
import 'package:tasky/features/home/home_screen.dart';
import 'package:tasky/features/profile/profile_screen.dart';
import 'package:tasky/features/tasks/todo_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = <Widget>[
    HomeScreen(),
    TodoTasksScreen(),
    CompletedTasksScreen(),
    ProfileScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
            BottomNavigationBarItem(
              icon: _buildNavigationCustomSvgPictureAsset(context , "assets/images/Home_Icon.svg" ,0),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: _buildNavigationCustomSvgPictureAsset(context , "assets/images/Todo_Icon.svg" ,1),
              label: "Todo"
            ),
            BottomNavigationBarItem(
              icon: _buildNavigationCustomSvgPictureAsset(context , "assets/images/Completed_Icon.svg" ,2),
              label: "Completed"
            ),
            BottomNavigationBarItem(
              icon: _buildNavigationCustomSvgPictureAsset(context , "assets/images/Profile_Icon.svg" ,3),
              label: "Profile"
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationCustomSvgPictureAsset(BuildContext context , String path , int index) {
    return CustomSvgPictureAsset.withColorFilter(
      path: path,
      color: (_currentIndex == index) ? Theme.of(context).colorScheme.onSecondaryFixed : Theme.of(context).colorScheme.onSecondaryFixedVariant,
    );
  }
}
