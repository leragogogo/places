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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SightCard(mocks[0]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SightCard(mocks[1]),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size(double.infinity, 136);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 136,
      title: Container(
        alignment: Alignment.bottomLeft,
        child: Text(
          AppStrings.titleText,
          maxLines: 2,
          style:
              theme.textTheme.bodyLarge?.copyWith(color: theme.backgroundColor),
        ),
      ),
      elevation: 0,
    );
  }
}
