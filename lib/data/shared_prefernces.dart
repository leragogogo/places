import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/first_entrance.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/redux/action/filters_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/ui/screen/res/app_themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkWithSharedPreferences extends ChangeNotifier {
  static Future<void> saveRadius() async {
    final pref = await SharedPreferences.getInstance();
    pref.setDouble('start', filterRepository.activeRadius.start);
    pref.setDouble('end', filterRepository.activeRadius.end);
  }

  static Future<void> saveCategories() async {
    final pref = await SharedPreferences.getInstance();
    var categories = <String>[];
    for (var i = 0; i < filterRepository.activeFilterItems.length; i++) {
      if (filterRepository.activeFilterItems[i].isSelected) {
        categories.add(filterRepository.activeFilterItems[i].name);
      }
    }
    pref.setStringList('categories', categories);
  }

  static Future<void> saveTheme(bool isDarkTheme) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('theme', isDarkTheme);
  }

  static Future<void> saveInformationAboutEntrance() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isFirstEntrance', false);
  }

  static Future<void> readTheme(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    context.read<SettingsInteractor>().settingsRepository.isDarkThemeOn =
        pref.getBool('theme') ?? false;
    context.read<SettingsInteractor>().settingsRepository.themeMode =
        context.read<SettingsInteractor>().settingsRepository.isDarkThemeOn
            ? AppThemes.darkTheme
            : AppThemes.lightTheme;
    context.read<SettingsInteractor>().notifyListeners();
  }

  static Future<void> readInformationAboutEntrance(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool('isFirstEntrance') == null) {
      isFirstEntrance = true;
    } else {
      isFirstEntrance = false;
    }
  }

  static Future<void> readRadiusWithAction(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    var rv =
        RangeValues(pref.getDouble('start') ?? 1, pref.getDouble('end') ?? 10);
    filterRepository.activeRadius = rv;
    filterRepository.candidateRadius = rv;

    StoreProvider.of<AppState>(context)
        .dispatch(ChangeRangeOfSliderAction(filterRepository.activeRadius));
  }

  static Future<void> readCategoriesWithAction(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    var categories = pref.getStringList('categories') ?? [];
    for (var i = 0; i < filterRepository.activeFilterItems.length; i++) {
      if (categories.contains(filterRepository.activeFilterItems[i].name)) {
        filterRepository.activeFilterItems[i].isSelected = true;
        filterRepository.candidateFilterItems[i].isSelected = true;
      } else {
        filterRepository.activeFilterItems[i].isSelected = false;
        filterRepository.candidateFilterItems[i].isSelected = false;
      }
      StoreProvider.of<AppState>(context).dispatch(
          ClickOnCategoryAction(filterRepository.activeFilterItems[i]));
    }
  }

  static Future<void> readRadius() async {
    final pref = await SharedPreferences.getInstance();
    var rv =
        RangeValues(pref.getDouble('start') ?? 1, pref.getDouble('end') ?? 10);
    filterRepository.activeRadius = rv;
    filterRepository.candidateRadius = rv;
  }

  static Future<void> readCategories() async {
    final pref = await SharedPreferences.getInstance();
    var categories = pref.getStringList('categories') ?? [];
    for (var i = 0; i < filterRepository.activeFilterItems.length; i++) {
      if (categories.contains(filterRepository.activeFilterItems[i].name)) {
        filterRepository.activeFilterItems[i].isSelected = true;
        filterRepository.candidateFilterItems[i].isSelected = true;
      } else {
        filterRepository.activeFilterItems[i].isSelected = false;
        filterRepository.candidateFilterItems[i].isSelected = false;
      }
    }
  }
}
