import 'package:flutter/material.dart';

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
        // тайтл с использованием виджета Text
        //title: const TextTitle(),

        // тайтл с использованием виджета RichText
        title: const RichTextTitle(),
        backgroundColor: const Color.fromARGB(1, 1, 1, 1),
        elevation: 0,
        toolbarHeight: 136,
      ),
    );
  }
}

// Тайтл с использованием виджета Text.
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

// Тайтл с использованием виджета RichText.
class RichTextTitle extends StatelessWidget {
  const RichTextTitle({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: SizedBox(
        width: 328,
        height: 72,
        child: RichText(
          text: const TextSpan(
            text: 'С',
            style: TextStyle(
              color: Color.fromRGBO(76, 175, 80, 1),
              fontSize: 32,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'писок\n',
                style: TextStyle(
                  color: Color.fromRGBO(37, 40, 73, 1),
                  fontSize: 32,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'и',
                style: TextStyle(
                  color: Color.fromRGBO(252, 221, 61, 1),
                  fontSize: 32,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'нтересных мест',
                style: TextStyle(
                  color: Color.fromRGBO(37, 40, 73, 1),
                  fontSize: 32,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
