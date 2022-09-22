import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/res/app_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

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
        title: const TextTitle(),
        backgroundColor: tabTextColor,
        elevation: 0,
        toolbarHeight: 136,
      ),
      body: Column(
        children: [
          SightCard(mocks[0]),
          SightCard(mocks[1]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
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

class TextTitle extends StatelessWidget {
  const TextTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: SizedBox(
        width: 328,
        height: 72,
        child: Text(
          textAlign: TextAlign.start,
          titleText,
          maxLines: 2,
          style: titleTextStyle,
        ),
      ),
    );
  }
}
