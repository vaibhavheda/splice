import 'package:flutter/material.dart';
import 'package:splice/constants/constants_strings.dart';
import 'package:splice/utils/storage_manager/storage_manager.dart';

class Themes {
  final ThemeData defualtTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ///
  final themesData = {
    ThemeNames.DARK: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black12,
    ),
    ThemeNames.LIGHT: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFE5E5E5),
      accentColor: Colors.black,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white54,
    )
  };

  ThemeData getThemeData(String theme) {
    return themesData[theme] ?? defualtTheme;
  }
}

class ThemeNotifier with ChangeNotifier {
  Themes themesObject = Themes();
  ThemeData _themeData = Themes().getThemeData(ThemeNames.LIGHT);
  ThemeData get getTheme => _themeData;

  ThemeNotifier() {
    StorageManager.readData(
      StorageManagerStrings.themeMode,
    ).then((value) {
      print('value read from storage: ' +
          StorageManagerStrings.themeMode +
          " " +
          value.toString());
      var themeMode = value ?? ThemeNames.LIGHT;
      setTheme(themeMode);
      // if (themeMode == 'light') {
      //   _themeData = themesObject.getThemeData();
      //   setLightMode();
      // } else {
      //   print('setting dark theme');
      //   _themeData = darkTheme;
      //   setDarkMode();
      // }
      // notifyListeners();
    });
  }

  void setTheme(String newTheme) async {
    _themeData = themesObject.getThemeData(newTheme);
    StorageManager.saveData(StorageManagerStrings.themeMode, newTheme);
    notifyListeners();
  }

  // void setDarkMode() async {
  //   _themeData = darkTheme;
  //   StorageManager.saveData('themeMode', 'dark');
  //   notifyListeners();
  // }

  // void setLightMode() async {
  //   _themeData = lightTheme;
  //   StorageManager.saveData('themeMode', 'light');
  //   notifyListeners();
  // }
}
