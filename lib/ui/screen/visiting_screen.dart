import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/res/app_styles.dart';
import 'package:places/ui/screen/widgets/sight_card_visited.dart';
import 'package:places/ui/screen/widgets/sight_card_want_to_visited.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisitingScreen();
}

class _VisitingScreen extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.favouriteButtonText,
            style: AppTypography.titleFavouriteTextStyle,
          ),
          backgroundColor: AppColors.tabTextColor,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.notSelectedColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                TabBar(
                  unselectedLabelColor: AppColors.textColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.titleColor,
                  ),
                  tabs: [
                    Tab(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Align(
                          child: Text(
                            'Хочу посетить',
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Align(
                          child: Text(
                            'Посетил',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SightCardWantToVisited(mocks[0]),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SightCardVisited(mocks[1]),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 2,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '3',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '4',
            ),
          ],
        ),
      ),
    );
  }
}
