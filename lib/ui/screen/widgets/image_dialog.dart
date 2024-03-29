import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/redux/action/add_sight_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          AlertDialog(
            backgroundColor: theme.appBarTheme.backgroundColor,
            insetPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 16,
              right: 16,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
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
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(UploadImageAction(context,1));
                    },
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
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(UploadImageAction(context,2));
                    },
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
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(UploadImageAction(context,3));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
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
                    AppStrings.cancelButtonText.toUpperCase(),
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: AppColors.planButtonColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
