import 'package:flutter/material.dart';
import 'package:places/data/repository/settings_repository.dart';
import 'package:places/data/shared_prefernces.dart';
import 'package:places/ui/screen/res/app_themes.dart';

class SettingsInteractor extends ChangeNotifier {
  static SettingsInteractor? _instance;
  final settingsRepository = SettingsRepository();
  // singleton
  factory SettingsInteractor() => _instance ?? SettingsInteractor._internal();
  SettingsInteractor._internal() {
    _instance = this;
  }

  Future<void> changeTheme() async {
    settingsRepository
      ..isDarkThemeOn = !settingsRepository.isDarkThemeOn
      ..themeMode = settingsRepository.isDarkThemeOn
          ? AppThemes.darkTheme
          : AppThemes.lightTheme;
    await WorkWithSharedPreferences.saveTheme(settingsRepository.isDarkThemeOn);
    notifyListeners();
  }
}
