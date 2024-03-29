import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screen/on_boarding_screen.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            AppStrings.settingsText,
            style:
                theme.textTheme.bodyMedium?.copyWith(color: theme.canvasColor),
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text(
              AppStrings.chooseThemeText,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.canvasColor),
            ),
            trailing: CupertinoSwitch(
              value: context
                  .watch<SettingsInteractor>()
                  .settingsRepository
                  .isDarkThemeOn,
              activeColor: AppColors.planButtonColor,
              onChanged: (value) async {
                await context.read<SettingsInteractor>().changeTheme();
              },
            ),
          ),
          ListTile(
            leading: Text(
              AppStrings.watchTutorialText,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.canvasColor),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: AppColors.planButtonColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<OnBoardingScreen>(
                    builder: (context) => const OnBoardingScreen(
                      isGoingToSettingsScreen: true,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
