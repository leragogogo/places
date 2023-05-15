import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class EmptyScreen extends StatelessWidget {
  final String path;
  final String text;

  const EmptyScreen({super.key, required this.path, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            path,
            height: 64,
            width: 64,
            color: theme.primaryColorDark,
          ),
          const SizedBox(height: 32),
          Text(
            AppStrings.emptyText,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
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
