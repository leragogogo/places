import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: theme.primaryColor,
        ),
        child: InkWell(
          child: Column(
            children: [
              UpperPart(sight),
              LowerPart(sight),
            ],
          ),
          onTap: () {
            // ignore: avoid_print
            print('Карточка нажата');
          },
        ),
      ),
    );
  }
}

// верхняя часть верстки карточки
class UpperPart extends StatelessWidget {
  final Sight sight;
  const UpperPart(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 96,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  sight.url,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : const CupertinoActivityIndicator(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: TextButton(
                onPressed: () {
                  // ignore: avoid_print
                  print('Кнопка добавить в избранное нажата.');
                },
                child: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                sight.type,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// нижняя часть верстки карточки
class LowerPart extends StatelessWidget {
  final Sight sight;
  const LowerPart(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 92,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16),
            alignment: Alignment.topLeft,
            child: Text(
              sight.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).backgroundColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 2, right: 16),
            alignment: Alignment.topLeft,
            child: Text(
              sight.details,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
