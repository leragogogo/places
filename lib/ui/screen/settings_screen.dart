import 'package:flutter/material.dart';
import 'package:places/main.dart';
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
        title: Text(
          AppStrings.settingsText,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.backgroundColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 42),
            child: Row(
              children: [
                Text(
                  AppStrings.chooseThemeText,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.backgroundColor),
                ),
                Switch(
                  value: context.watch<ThemeModel>().isDarkTheme,
                  // ignore: unnecessary_parenthesis
                  onChanged: ((value) {
                    context.read<ThemeModel>().changeTheme();
                  }),
                  activeColor: AppColors.planButtonColor,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Divider(
            height: 36,
            color: AppColors.ltTextColor,
            indent: 16,
            endIndent: 16,
            thickness: 0.8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Text(
                  AppStrings.watchTutorialText,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.backgroundColor),
                ),
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    color: AppColors.planButtonColor,
                  ),
                  onPressed: () {
                    // ignore: avoid_print
                    print('Инфо кнопка нажата');
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Divider(
            height: 36,
            color: AppColors.ltTextColor,
            indent: 16,
            endIndent: 16,
            thickness: 0.8,
          ),
        ],
      ),
    );
  }
}
