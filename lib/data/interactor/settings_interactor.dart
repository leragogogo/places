import 'package:flutter/material.dart';
import 'package:places/data/repository/settings_repository.dart';

class SettingsInteractor extends ChangeNotifier {
  static SettingsInteractor? _instance;
  final settingsRepository = SettingsRepository();
  bool get isDarkThemeOn => settingsRepository.isDarkThemeOn;
  // singleton
  factory SettingsInteractor() => _instance ?? SettingsInteractor._internal();
  SettingsInteractor._internal() {
    _instance = this;
  }

  void changeTheme() {
    settingsRepository.isDarkThemeOn = !settingsRepository.isDarkThemeOn;
    notifyListeners();
  }
}
