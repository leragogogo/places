import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AlertDialog(
              backgroundColor: theme.appBarTheme.backgroundColor,
              insetPadding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.5,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: ImageIcon(
                      const AssetImage(AppAssets.cameraAsset),
                      color: theme.primaryColorDark,
                    ),
                    title: Text(
                      AppStrings.cameraText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColorDark,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Divider(
                    height: 26,
                    color: AppColors.ltTextColor,
                    indent: 16,
                    endIndent: 16,
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: ImageIcon(
                      const AssetImage(AppAssets.photoAsset),
                      color: theme.primaryColorDark,
                    ),
                    title: Text(
                      AppStrings.photoText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColorDark,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Divider(
                    height: 26,
                    color: AppColors.ltTextColor,
                    indent: 16,
                    endIndent: 16,
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: ImageIcon(
                      const AssetImage(AppAssets.fileAsset),
                      color: theme.primaryColorDark,
                    ),
                    title: Text(
                      AppStrings.fileText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColorDark,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.appBarTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    'ОТМЕНА',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: AppColors.planButtonColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
