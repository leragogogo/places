import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_strings.dart';

// задний фон Dissmissable для удаления карточек
class DeletingBackgroud extends StatelessWidget {
  const DeletingBackgroud({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restore_from_trash,
              color: Theme.of(context).canvasColor,
            ),
            Text(
              AppStrings.deleteText,
              style: TextStyle(
                color: Theme.of(context).canvasColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
