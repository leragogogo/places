import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_colors.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const BottomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.planButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: onPressed,
            child: Center(
              child: Text(
                text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
