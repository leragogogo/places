import 'package:flutter/material.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class AddNewSightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 177,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.gradientStartColor,
            AppColors.planButtonColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<AddSightScreen>(
              builder: (context) => const AddSightScreen(),
            ),
          );
        },
        child: Center(
          child: Row(
            children: const [
              Icon(Icons.add),
              Text(
                AppStrings.newSightText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
