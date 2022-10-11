import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class SightCardVisited extends StatelessWidget {
  final Sight sight;
  const SightCardVisited(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UpperPartVisited(sight),
        LowerPartVisited(sight),
      ],
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
          top: 16,
          right: 16,
          child: SizedBox(
            width: 60,
            child: Row(
              children: const [
                SizedBox(
                  width: 12,
                  height: 12,
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12,
                  height: 12,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}

// нижняя часть верстки карточки
class LowerPartVisited extends StatelessWidget {
  final Sight sight;
  const LowerPartVisited(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16),
            alignment: Alignment.topLeft,
            child: Text(
              sight.name,
              style: AppTypography.nameTextStyle
                  ?.copyWith(color: Theme.of(context).backgroundColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 2, right: 16),
            alignment: Alignment.topLeft,
            child: Text(
              'Цель достигнута 12 октября.',
              style: AppTypography.descriptionTextStyle
                  ?.copyWith(color: AppColors.planButtonColor),
            ),
          ),
        ],
      ),
    );
  }
}
