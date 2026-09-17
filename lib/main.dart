import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/shared/file_storage_manager.dart';
import 'package:tasky/core/shared/shared_preferences_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await SharedPreferencesManager().init();
  await FileStorageManager().init();
  ThemeController.init();
  final String? username = SharedPreferencesManager().getString(StorageKey.usernameKey);
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.username});

  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (BuildContext context , ThemeMode value , Widget? child) {
        return ChangeNotifierProvider<TasksController>(
          create: (_) => TasksController()..loadTasks(),
          child: ScreenUtilInit(
            designSize: Size(375, 809),
            minTextAdapt: true,
            builder: (context , _){
              return MaterialApp(
                title: 'Tasky',
                debugShowCheckedModeBanner: false,
                theme: lightTheme(context),
                darkTheme: darkTheme(context),
                themeMode: value,
                home: (username != null) ? MainScreen() : WelcomeScreen(),
              );
            },
          ),
        );
      }
    );
  }
}
