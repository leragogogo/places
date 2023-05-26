import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onChanged;
  final Function() onTap;
  final bool readOnly;
  final Widget suffixIcon;
  final TextEditingController? controller;

  @override
  Size get preferredSize => const Size(double.infinity, 40);

  const SearchBar({
    required this.readOnly,
    required this.onChanged,
    required this.onTap,
    required this.suffixIcon,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      readOnly: readOnly,
      autofocus: true,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.primaryColorDark,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: ImageIcon(
          const AssetImage(AppAssets.searchAsset),
          color: theme.primaryColorDark,
        ),
        suffixIcon: suffixIcon,
        fillColor: theme.primaryColor,
        filled: true,
        hintText: AppStrings.hintText,
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.primaryColorDark,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 3, color: theme.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 3, color: theme.primaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 3, color: theme.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 3, color: theme.primaryColor),
        ),
      ),
      onChanged: onChanged,
      onTap: onTap,
      controller: controller,
    );
  }
}
