import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/widgets/parts_of_card.dart';

class SightCardVisited extends StatelessWidget {
  final Sight sight;
  const SightCardVisited(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 2,
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: theme.primaryColor,
        ),
        child: Stack(
          children: [
            UpperPart(sight),
            Positioned(
              top: 96,
              left: 16,
              child: LowerPart(
                sight,
                Text(
                  'Цель достигнута 12 октября.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.planButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    debugPrint('Клик по фото');
                  },
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      debugPrint('Кнопка поделиться нажата.');
                    },
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      debugPrint('Кнопка закрыть нажата.');
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
