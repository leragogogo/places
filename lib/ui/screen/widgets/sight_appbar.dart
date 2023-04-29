import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class SightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget bottom;
  final Widget? leading;
  @override
  Size get preferredSize => const Size(double.infinity, 136);

  const SightAppBar({required this.bottom, required this.leading, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 136,
      title: Container(
        alignment: Alignment.center,
        child: Text(
          AppStrings.titleText,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.canvasColor,
            fontSize: 18,
          ),
        ),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: bottom,
        ),
      ),
      leading: leading,
      automaticallyImplyLeading: false,
    );
  }
}
