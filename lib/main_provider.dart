import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{

  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(){
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      notifyListeners();
    }else {
      themeMode = ThemeMode.light;
      notifyListeners();
    }
  }
}