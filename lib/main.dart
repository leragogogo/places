import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/app_themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeModel(),
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: AppThemes.lightTheme,
      //home: FiltersScreen(),
      theme: context.watch<ThemeModel>().isDarkTheme
          ? AppThemes.darkTheme
          : AppThemes.lightTheme,
      home: const MainScreens(),
    );
  }
}

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _curPage = 0;
  late PageController _control;
  @override
  void initState() {
    _control = PageController(
      initialPage: _curPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          _control.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Список мест',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
      body: PageView(
        controller: _control,
        onPageChanged: (page) {
          setState(() {
            _curPage = page;
          });
        },
        children: [
          const Center(child: SightListScreen()),
          // временно
          Center(child: SightDetailsScreen(mocks[0])),
          const Center(child: VisitingScreen()),
          const Center(child: SettingsScreen()),
        ],
      ),
    );
  }
}

class ThemeModel with ChangeNotifier {
  bool get isDarkTheme => _isDarkTheme;

  bool _isDarkTheme = false;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
