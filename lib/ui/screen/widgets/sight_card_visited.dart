import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_colors.dart';

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
      child: InkWell(
        child: Column(
          children: [
            UpperPartVisited(sight),
            LowerPartVisited(sight),
          ],
        ),
        onTap: () {
            // ignore: avoid_print
            print('Карточка нажата');
          },
      ),
    );
  }
}

// верхняя часть верстки карточки
class UpperPartVisited extends StatelessWidget {
  final Sight sight;
  const UpperPartVisited(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            child: Row(
              children: [
                TextButton(
                    onPressed: (){
                      // ignore: avoid_print
                      print('Кнопка поделиться нажата.');
                    }, 
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                ),
                TextButton(
                  onPressed: (){
                    // ignore: avoid_print
                    print('Кнопка закрыть нажата.');
                  }, 
                  child:const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}

// нижняя часть верстки карточки
class LowerPartVisited extends StatelessWidget {
  final Sight sight;
  const LowerPartVisited(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
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
              'Цель достигнута 12 октября.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.planButtonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
