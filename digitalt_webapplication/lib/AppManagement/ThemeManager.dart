import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'StorageManager.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    accentColor: Colors.red,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black, iconTheme: IconThemeData(color: Colors.red)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(unselectedItemColor: Colors.redAccent),
    buttonColor: Colors.red

    //canvasColor: Colors.amberAccent
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.green
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    appBarTheme: AppBarTheme(backgroundColor: Colors.red),
    buttonColor: Colors.blue,


  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}