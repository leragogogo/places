import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class NetworkErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.errorAsset,
            height: 64,
            width: 64,
            color: theme.primaryColorDark,
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.errorText1,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 20,
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.errorText2,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
