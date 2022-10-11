import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
      child: Column(
        children: [
          UpperPart(sight),
          LowerPart(sight),
        ],
      ),
    );
  }
}

// верхняя часть верстки карточки
class UpperPart extends StatelessWidget {
  final Sight sight;
  const UpperPart(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
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
        const Positioned(
          top: 19,
          right: 18,
          child: Icon(
            Icons.favorite_outline,
            color: Colors.white,
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
class LowerPart extends StatelessWidget {
  final Sight sight;
  const LowerPart(this.sight, {Key? key}) : super(key: key);

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
              sight.details,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.descriptionTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
