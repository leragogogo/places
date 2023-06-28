import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/res/app_colors.dart';

//верхняя часть верстки карточки с изображением
class UpperPart extends StatelessWidget {
  final Place place;
  const UpperPart(this.place, {Key? key}) : super(key: key);

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
            child: CachedNetworkImage(
              imageUrl:
                  place.urls.isEmpty ? 'https://aa.aa.ru/1.jpg' : place.urls[0],
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, dynamic error) => Container(
                color: AppColors.planButtonColor,
                alignment: Alignment.center,
                child: const Text(
                  'Whoops!',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            place.beatifulType,
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
  final Place sight;
  final Text text;
  const LowerPart(this.sight, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            sight.name,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).canvasColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: text,
        ),
      ],
    );
  }
}
