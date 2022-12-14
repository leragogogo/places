import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SightListScreen();
}

class _SightListScreen extends State<SightListScreen> {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.titleText,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SightCard(mocks[0]),
          SightCard(mocks[1]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
