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
          create: (_) => SettingsInteractor(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChoosingCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddSightProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ButtonSaveProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ButtonCreateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FieldEmptyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WantToVisitProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VisitedProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlaceInteractor(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchInteractor(),
        ),
        ChangeNotifierProvider(
          create: (_) => FilterInteractor(),
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
      theme: context.watch<SettingsInteractor>().themeMode,
      home: const SplashScreen(),
    );
  }
}
