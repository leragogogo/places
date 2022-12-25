import 'package:flutter/material.dart';
import 'package:places/data_providers/theme_provider.dart';
import 'package:places/main_screens.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/app_themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FiltersProvider(),
      //create: (context) => ThemeProvider(),
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
      home: FiltersScreen(),
      //theme: context.watch<ThemeProvider>().themeMode,
      //home: const MainScreens(),
    );
  }
}
