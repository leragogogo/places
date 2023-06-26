import 'package:flutter/material.dart';
import 'package:places/data/interactor/filter_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data_providers/add_sight_provider.dart';
import 'package:places/data_providers/button_create_provider.dart';
import 'package:places/data_providers/button_save_provider.dart';
import 'package:places/data_providers/choosing_category_provider.dart';
import 'package:places/data_providers/field_empty_provider.dart';
import 'package:places/data_providers/filter_provider.dart';
import 'package:places/data_providers/history_provider.dart';
import 'package:places/data_providers/search_provider.dart';
import 'package:places/data_providers/visited_provider.dart';
import 'package:places/data_providers/want_to_visit_provider.dart';
import 'package:places/ui/screen/res/app_themes.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FiltersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsInteractor(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChoosingCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddSightProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ButtonSaveProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ButtonCreateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FieldEmptyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WantToVisitProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VisitedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaceInteractor(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchInteractor(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterInteractor(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places',
      theme: context.watch<SettingsInteractor>().isDarkThemeOn
          ? AppThemes.darkTheme
          : AppThemes.lightTheme,
      home: const SplashScreen(),
    );
  }
}
