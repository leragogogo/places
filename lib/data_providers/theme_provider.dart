import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get themeMode => _themeMode;
  bool _isDarkTheme = false;

  var _themeMode = AppThemes.lightTheme;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    _themeMode = _themeMode == AppThemes.lightTheme
        ? AppThemes.darkTheme
        : AppThemes.lightTheme;
    notifyListeners();
  }
}
