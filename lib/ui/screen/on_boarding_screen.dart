import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: _currentPage < 2
            ? [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.skipText,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.planButtonColor,
                    ),
                  ),
                ),
              ]
            : [],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView(
              controller: _controller,
              children: const [
                _Page(
                  icon: AppAssets.page1Asset,
                  boldText: AppStrings.page1BoldText,
                  text: AppStrings.page1Text,
                ),
                _Page(
                  icon: AppAssets.page2Asset,
                  boldText: AppStrings.page2BoldText,
                  text: AppStrings.page2Text,
                ),
                _Page(
                  icon: AppAssets.page3Asset,
                  boldText: AppStrings.page3BoldText,
                  text: AppStrings.page3Text,
                ),
              ],
            ),
          ),
          Expanded(
            child: _Indicators(
              selectedindex: _currentPage,
            ),
          ),
          if (_currentPage == 2)
            Expanded(
              child: BottomButton(
                text: AppStrings.onStartText,
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final String icon;
  final String boldText;
  final String text;
  const _Page({
    required this.icon,
    required this.boldText,
    required this.text,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(
            AssetImage(icon),
            color: theme.canvasColor,
            size: 100,
          ),
          const SizedBox(
            height: 42,
          ),
          Text(
            boldText,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.canvasColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicators extends StatelessWidget {
  final int selectedindex;
  const _Indicators({required this.selectedindex, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    for (var i = 0; i < 3; i++) {
      list
        ..add(i == selectedindex
            ? const _Indicator(isActive: true)
            : const _Indicator(isActive: false))
        ..add(const SizedBox(
          width: 8,
        ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}

class _Indicator extends StatelessWidget {
  final bool isActive;
  const _Indicator({required this.isActive, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.planButtonColor : theme.primaryColorDark,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
