import 'package:flutter/material.dart';
import '../constants/storage_key.dart';
import '../shared/shared_preferences_manager.dart';

abstract class ThemeController{
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

  static void init(){
    final bool themeResult = SharedPreferencesManager().getBool(StorageKey.themeKey) ?? true;
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
      await SharedPreferencesManager().setBool(StorageKey.themeKey, false);
    }else{
      themeNotifier.value = ThemeMode.dark;
      await SharedPreferencesManager().setBool(StorageKey.themeKey, true);
    }
  }

  static bool isDarkThemeMode() => themeNotifier.value == ThemeMode.dark;

}