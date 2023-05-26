import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final intialized = Future.delayed(const Duration(seconds: 2), () => true);

  @override
  void initState() {
    _navigateToNext();
    super.initState();
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
          child: ImageIcon(
            const AssetImage(AppAssets.splashAsset),
            color: theme.appBarTheme.backgroundColor,
            size: 200,
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    if (await intialized) {
      debugPrint('Переход на следующий экран');
    }
  }
}
