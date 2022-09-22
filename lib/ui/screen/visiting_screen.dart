import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/res/app_styles.dart';
import 'package:places/ui/screen/sight_card_visited.dart';
import 'package:places/ui/screen/sight_card_want_to_visited.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisitingScreen();
}

class _VisitingScreen extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          favouriteButtonText,
          style: titleFavouriteTextStyle,
        ),
        backgroundColor: tabTextColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: notSelectedColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _tabController.index == 0
                                  ? titleColor
                                  : notSelectedColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              'Хочу посетить',
                              style: _tabController.index == 0
                                  ? tabTextStyle1
                                  : tabTextStyle2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _tabController.index == 1
                                  ? titleColor
                                  : notSelectedColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              'Посетил',
                              style: _tabController.index == 1
                                  ? tabTextStyle1
                                  : tabTextStyle2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
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
    );
  }
}
