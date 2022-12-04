import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: AppStrings.label1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: AppStrings.label2,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            label: AppStrings.label3,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppStrings.label4,
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}