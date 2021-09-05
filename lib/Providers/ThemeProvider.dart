import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier {

  ThemeMode themeMode=ThemeMode.light;
  toggleTheme(){
    themeMode=themeMode==ThemeMode.light?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
}