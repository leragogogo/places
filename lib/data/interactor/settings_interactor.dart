import 'package:flutter/material.dart';
import 'package:places/data/repository/settings_repository.dart';
import 'package:places/ui/screen/res/app_themes.dart';

class SettingsInteractor extends ChangeNotifier {
  static SettingsInteractor? _instance;
  final settingsRepository = SettingsRepository();
  bool get isDarkThemeOn => settingsRepository.isDarkThemeOn;
  ThemeData get themeMode => settingsRepository.themeMode;
  // singleton
  factory SettingsInteractor() => _instance ?? SettingsInteractor._internal();
  SettingsInteractor._internal() {
    _instance = this;
  }

  void changeTheme() {
    settingsRepository..isDarkThemeOn = !settingsRepository.isDarkThemeOn
    ..themeMode = settingsRepository.isDarkThemeOn ? AppThemes.darkTheme : AppThemes.lightTheme;
    notifyListeners();
  }
}
