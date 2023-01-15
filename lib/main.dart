import 'package:flutter/material.dart';
import 'package:places/data_providers/filter_provider.dart';
import 'package:places/data_providers/theme_provider.dart';
import 'package:places/main_screens.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/app_themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FiltersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
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
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      home: const FiltersScreen(),
      // временное переключение до прохождения соответствующего урока
      //theme: context.watch<ThemeProvider>().themeMode,
      //home: const MainScreens(),
    );
  }
}
