import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data_providers/theme_provider.dart';
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
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.backgroundColor),
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text(
              AppStrings.chooseThemeText,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.backgroundColor),
            ),
            trailing: CupertinoSwitch(
              value: context.watch<ThemeProvider>().isDarkTheme,
              activeColor: AppColors.planButtonColor,
              // ignore: unnecessary_parenthesis
              onChanged: ((value) {
                context.read<ThemeProvider>().changeTheme();
              }),
            ),
          ),
          ListTile(
            leading: Text(
              AppStrings.watchTutorialText,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.backgroundColor),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: AppColors.planButtonColor,
              ),
              onPressed: () {
                debugPrint('Инфо кнопка нажата');
              },
            ),
          ),
        ],
      ),
    );
  }
}
