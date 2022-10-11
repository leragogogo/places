import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight sight;

  const SightDetailsScreen(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ImageDetails(sight),
          NameOfSight(sight),
          TypeOfSight(sight),
          DetailsOfSight(sight),
          BuildRouteButton(sight),
          Divider(
            height: 39,
            color: AppColors.ltTextColor,
            indent: 16,
            endIndent: 16,
            thickness: 0.8,
          ),
          RowOfLowerButtons(sight),
        ],
      ),
    );
  }
}

// верстка изображений объекта
class ImageDetails extends StatelessWidget {
  final Sight sight;

  const ImageDetails(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 360,
          child: Image.network(
            sight.url,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : const CupertinoActivityIndicator(),
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned(
          top: 36,
          left: 16,
          child: Container(
            width: 32,
            height: 32,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// верстка имени объекта
class NameOfSight extends StatelessWidget {
  final Sight sight;

  const NameOfSight(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24),
      alignment: Alignment.topLeft,
      child: Text(
        sight.name,
        style: AppTypography.nameDetailsTextStyle
            ?.copyWith(color: Theme.of(context).backgroundColor),
      ),
    );
  }
}

// верстка типа объекта
class TypeOfSight extends StatelessWidget {
  final Sight sight;

  const TypeOfSight(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 2),
      alignment: Alignment.topLeft,
      child: Text(
        sight.type,
        style: AppTypography.typeAndDetailsTextStyle
            ?.copyWith(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}

// верстка описания объекта
class DetailsOfSight extends StatelessWidget {
  final Sight sight;

  const DetailsOfSight(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
      alignment: Alignment.topLeft,
      child: Text(
        sight.details,
        style: AppTypography.typeAndDetailsTextStyle
            ?.copyWith(color: Theme.of(context).backgroundColor),
      ),
    );
  }
}

// верстка кнопки(пока заглушка) построить маршрут
class BuildRouteButton extends StatelessWidget {
  final Sight sight;

  const BuildRouteButton(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
      child: Container(
        padding: const EdgeInsets.only(
          left: 16,
          top: 15,
          right: 16,
          bottom: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.planButtonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                AppStrings.buildRouteButtonText,
                style: AppTypography.buildRouteButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// верстка кнопок(пока заглушки) в избранное и запланировать
class RowOfLowerButtons extends StatelessWidget {
  final Sight sight;

  const RowOfLowerButtons(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          AppStrings.planButtomText,
          style: AppTypography.buttomTextStyle
              ?.copyWith(color: Theme.of(context).primaryColorDark),
        ),
        Text(
          AppStrings.favouriteButtonText,
          style: AppTypography.buttomTextStyle
              ?.copyWith(color: Theme.of(context).backgroundColor),
        ),
      ],
    );
  }
}
