import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
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
      appBar: const CustomAppBar(136),
      body: Column(
        children: [
          SightCard(mocks[0]),
          SightCard(mocks[1]),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double height;
  
  const CustomAppBar(this.height, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const TextTitle(),
      backgroundColor: const Color.fromARGB(1, 1, 1, 1),
      elevation: 0,
      toolbarHeight: height,
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(height);
}

class TextTitle extends StatelessWidget {
  const TextTitle({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: SizedBox(
        width: 328,
        height: 72,
        child: Text(
          'Список\nинтересных мест',
          maxLines: 2,
          style: TextStyle(
            color: Color.fromRGBO(37, 40, 73, 1),
            fontSize: 32,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
