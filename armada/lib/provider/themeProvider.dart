import 'package:flutter/material.dart';

// class ThemeProvider extends ChangeNotifier {
//   bool _isDarkMode = true;

//   bool get isDarkMode => _isDarkMode;

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }
// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// enum ThemeMode { light, dark }

class ThemeProvider with ChangeNotifier {
  // ThemeMode _currentThemeMode = ThemeMode.light;
  bool _currentThemeMode = false;

  bool get currentThemeMode => _currentThemeMode;

  void toggleTheme() async {
    _currentThemeMode = _currentThemeMode == false ? true : false;
    notifyListeners();
    print(_currentThemeMode);

    final prefs = await SharedPreferences.getInstance();
    // prefs.setString('themeMode', _currentThemeMode);
    prefs.setBool("themeMode", _currentThemeMode);
  }

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getBool('themeMode');
    print(savedThemeMode);
    print(_currentThemeMode);
    print("second");

    if (savedThemeMode != null) {
      _currentThemeMode = savedThemeMode;
      print(_currentThemeMode);
      print("check");
    } else {
      print("what");
    }
    print(_currentThemeMode);
    notifyListeners();
  }
}
