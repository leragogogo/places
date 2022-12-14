import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_themes.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.darkTheme,
      //theme: AppThemes.lightTheme,
      //home: SightDetailsScreen(mocks[0]),
      //home: SightListScreen(),
      home: VisitingScreen(),
    );
  }
}
