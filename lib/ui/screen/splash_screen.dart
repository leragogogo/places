import 'dart:math';
import 'package:flutter/material.dart';
import 'package:places/data/first_entrance.dart';
import 'package:places/data/shared_prefernces.dart';
import 'package:places/main_screens.dart';
import 'package:places/ui/screen/on_boarding_screen.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final intialized = Future.delayed(const Duration(seconds: 4), () => true);
  late AnimationController _animationController;

  @override
  void initState() {
    WorkWithSharedPreferences.readInformationAboutEntrance(context);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationController.repeat();
    _navigate();
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

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              AppColors.gradientStartColor,
              AppColors.planButtonColor,
            ],
          ),
        ),
        child: Center(
            child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _animationController.value * 2 * pi,
              child: ImageIcon(
                const AssetImage(AppAssets.splashAsset),
                color: theme.appBarTheme.backgroundColor,
                size: 200,
              ),
            );
          },
        )),
      ),
    );
  }

  Future<void> _navigate() async {
    if (await intialized) {
      isFirstEntrance ? _navigateToOnboarding() : _navigateToNext();
    }
  }

  Future<void> _navigateToNext() async {
    if (context.mounted) {
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute<MainScreens>(
        builder: (context) => const MainScreens(),
      ));
    }
  }

  Future<void> _navigateToOnboarding() async {
    if (context.mounted) {
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute<MainScreens>(
        builder: (context) =>
            const OnBoardingScreen(isGoingToSettingsScreen: false),
      ));
    }
  }
}
