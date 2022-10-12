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
          _ImageDetails(sight),
          _NameOfSight(sight),
          _TypeOfSight(sight),
          _DetailsOfSight(sight),
          _BuildRouteButton(sight),
          Divider(
            height: 39,
            color: AppColors.ltTextColor,
            indent: 16,
            endIndent: 16,
            thickness: 0.8,
          ),
          _RowOfLowerButtons(sight),
        ],
      ),
    );
  }
}

// верстка изображений объекта
class _ImageDetails extends StatelessWidget {
  final Sight sight;

  const _ImageDetails(this.sight, {Key? key}) : super(key: key);
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
class _NameOfSight extends StatelessWidget {
  final Sight sight;

  const _NameOfSight(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24),
      alignment: Alignment.topLeft,
      child: Text(
        sight.name,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.backgroundColor,
          fontSize: 24,
        ),
      ),
    );
  }
}

// верстка типа объекта
class _TypeOfSight extends StatelessWidget {
  final Sight sight;

  const _TypeOfSight(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 2),
      alignment: Alignment.topLeft,
      child: Text(
        sight.type,
        style: theme.textTheme.bodySmall
            ?.copyWith(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}

// верстка описания объекта
class _DetailsOfSight extends StatelessWidget {
  final Sight sight;

  const _DetailsOfSight(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
      alignment: Alignment.topLeft,
      child: Text(
        sight.details,
        style: theme.textTheme.bodySmall
            ?.copyWith(color: Theme.of(context).backgroundColor),
      ),
    );
  }
}

// верстка кнопки(пока заглушка) построить маршрут
class _BuildRouteButton extends StatelessWidget {
  final Sight sight;

  const _BuildRouteButton(this.sight, {Key? key}) : super(key: key);
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
class _RowOfLowerButtons extends StatelessWidget {
  final Sight sight;

  const _RowOfLowerButtons(this.sight, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          AppStrings.planButtomText,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.primaryColorDark),
        ),
        Text(
          AppStrings.favouriteButtonText,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.backgroundColor),
        ),
      ],
    );
  }
}
