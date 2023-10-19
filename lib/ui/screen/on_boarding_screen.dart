import 'package:flutter/material.dart';
import 'package:places/data/shared_prefernces.dart';
import 'package:places/main_screens.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  final bool isGoingToSettingsScreen;
  const OnBoardingScreen({required this.isGoingToSettingsScreen, Key? key})
      : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  double _buttonOpacity = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.toInt();
        _buttonOpacity = _currentPage == 2 ? 1 : 0;
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
                  onPressed: () async {
                    widget.isGoingToSettingsScreen
                        ? Navigator.pop(context)
                        : _navigateToMainScreens();
                    await WorkWithSharedPreferences
                        .saveInformationAboutEntrance();
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
            flex: 2,
            child: Stack(
              children: [
                PageView(
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
                Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2 - 32,
                  child: _Indicators(
                    selectedindex: _currentPage,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: _buttonOpacity,
              child: BottomButton(
                text: AppStrings.onStartText,
                onPressed: () async {
                  widget.isGoingToSettingsScreen
                      ? Navigator.pop(context)
                      : _navigateToMainScreens();
                  await WorkWithSharedPreferences
                      .saveInformationAboutEntrance();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToMainScreens() async {
    if (context.mounted) {
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute<MainScreens>(
        builder: (context) => const MainScreens(),
      ));
    }
  }
}

class _Page extends StatefulWidget {
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
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(seconds: 1));
    _animationController.forward();

    _sizeAnimation = Tween<double>(begin: 0, end: 150).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _animationController.value,
                  child: ImageIcon(
                    AssetImage(widget.icon),
                    color: theme.canvasColor,
                    size: _sizeAnimation.value,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Text(
              widget.boldText,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.canvasColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.primaryColorDark,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
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
