import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/shared/shared_preferences_manager.dart';

class HomeController with ChangeNotifier {
  String username = "";
  String motivationQuote = "";
  File? profileImage;

  void init() {
    loadUsername();
    loadMotivationQuote();
    loadImage();
  }

  void loadUsername() {
    username =
        SharedPreferencesManager().getString(StorageKey.usernameKey) ?? 'Guest';
    notifyListeners();
  }

  void loadMotivationQuote() {
    motivationQuote =
        SharedPreferencesManager().getString(StorageKey.motivationQuoteKey) ??
        "One task at a time. One step closer.";
    notifyListeners();
  }

  void loadImage() {
    final String? imagePath = SharedPreferencesManager().getString(StorageKey.imageKey);
    if (imagePath != null) {
      profileImage = File(imagePath);
    }
    notifyListeners();
  }
}
