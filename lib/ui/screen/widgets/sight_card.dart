import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/widgets/parts_of_card.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

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
                  sight.details,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.primaryColorDark,
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
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  debugPrint('Кнопка добавить в избранное нажата.');
                },
                child: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
