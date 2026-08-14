import 'package:flutter/material.dart';
import '../shared/shared_preferences_manager.dart';

abstract class ThemeController{
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

  static void init(){
    final bool themeResult = SharedPreferencesManager().getBool("theme") ?? true;
    if(themeResult){
      themeNotifier.value = ThemeMode.dark;
    }
    else{
      themeNotifier.value = ThemeMode.light;
    }
  }

  static void toggleTheme() async{
    if(themeNotifier.value == ThemeMode.dark){
      themeNotifier.value = ThemeMode.light;
      await SharedPreferencesManager().setBool("theme", false);
    }else{
      themeNotifier.value = ThemeMode.dark;
      await SharedPreferencesManager().setBool("theme", true);
    }
  }

  static bool isDarkThemeMode() => themeNotifier.value == ThemeMode.dark;

}