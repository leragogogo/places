import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class AddSightError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: AlertDialog(
        backgroundColor: theme.appBarTheme.backgroundColor,
        insetPadding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          bottom: MediaQuery.of(context).size.height * 0.3,
          left: 16,
          right: 16,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.errorAsset,
                  height: 100,
                  width: 100,
                  color: AppColors.planButtonColor,
                ),
                Text(
                  AppStrings.addSightErrorText1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 18,
                        color: AppColors.planButtonColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  AppStrings.addSightErrorText2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 18,
                        color: AppColors.planButtonColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            child: Text(AppStrings.okButtonText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 18,
                      color: AppColors.planButtonColor,
                      fontWeight: FontWeight.bold,
                    )),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
