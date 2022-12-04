import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/widgets/parts_of_card.dart';

class SightCardVisited extends StatelessWidget {
  final Sight sight;
  const SightCardVisited(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Ink(
      height: 192,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        color: theme.primaryColor,
      ),
      child: Stack(
        children: [
          ImagePart(sight),
          Positioned(
            top: 96,
            left: 16,
            child: LowerPart(sight),
          ),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  // ignore: avoid_print
                  print('Клик по фото');
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
                    // ignore: avoid_print
                    print('Кнопка поделиться нажата.');
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
                    // ignore: avoid_print
                    print('Кнопка закрыть нажата.');
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
    );
  }
}
