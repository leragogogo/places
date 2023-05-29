import 'dart:isolate';
import 'dart:math';
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
    _doInitWork();
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

  static Future<void> _isolateInitialize() async {
    final port = ReceivePort();
    await Isolate.spawn(
      (message) {
        var list = _generateList();
        debugPrint(list.toString().substring(0, 100));
        list = _reverseList(list);
        debugPrint(list.toString().substring(0, 100));
      },
      port.sendPort,
    );
  }

  static List<String> _generateList() =>
      List.generate(200000, (index) => Random().nextDouble().toString());

  static List<String> _reverseList(List<String> list) =>
      list.map((str) => str.split('').reversed.join()).toList();

  Future<void> _doInitWork() async {
    debugPrint('sync start: ${DateTime.now()}');
    _syncInitialize();
    debugPrint('sync end: ${DateTime.now()}');

    debugPrint('isolate start: ${DateTime.now()}');
    await _isolateInitialize();
    debugPrint('isolate end: ${DateTime.now()}');

    debugPrint('future start: ${DateTime.now()}');
    await _futureIntialize();
    debugPrint('future end: ${DateTime.now()}');
  }

  Future<void> _navigateToNext() async {
    if (await intialized) {
      debugPrint('Переход на следующий экран');
    }
  }

  void _syncInitialize() {
    var list = _generateList();
    debugPrint(list.toString().substring(0, 100));
    list = _reverseList(list);
    debugPrint(list.toString().substring(0, 100));
  }

  Future<void> _futureIntialize() async {
    var list = _generateList();
    debugPrint(list.toString().substring(0, 100));
    list = _reverseList(list);
    debugPrint(list.toString().substring(0, 100));
  }
}
