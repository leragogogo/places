import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class SightDetailsScreen extends StatefulWidget {
  final Place place;

  const SightDetailsScreen(this.place, {Key? key}) : super(key: key);

  @override
  State<SightDetailsScreen> createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: theme.appBarTheme.backgroundColor,
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 360,
            automaticallyImplyLeading: false,
            flexibleSpace: _ImageDetails(
              place: widget.place,
              selectedindex: _currentPage,
              controller: _controller,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _NameOfSight(widget.place),
                _TypeOfSight(widget.place),
                _DetailsOfSight(widget.place),
                _BuildRouteButton(widget.place),
                Divider(
                  height: 39,
                  color: AppColors.ltTextColor,
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.8,
                ),
                _RowOfLowerButtons(widget.place),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SightPageView extends StatelessWidget {
  final Place place;
  final int selectedindex;
  final PageController controller;

  const _SightPageView({
    required this.place,
    required this.selectedindex,
    required this.controller,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        PageView(
          controller: controller,
          children: place.urls
              .map(
                (image) => ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, dynamic error) => Container(
                      color: theme.primaryColor,
                      alignment: Alignment.center,
                      child: Center(
                        child: Image.asset(
                          AppAssets.placeholderAsset,
                          width: 500,
                          height: 500,
                        ),
                      ), 
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
        ),
        Positioned(
          bottom: 0,
          left: selectedindex *
              (MediaQuery.of(context).size.width / place.urls.length),
          child: _Indicators(
            selectedindex: selectedindex,
            place: place,
          ),
        ),
      ],
    );
  }
}

class _Indicators extends StatelessWidget {
  final int selectedindex;
  final Place place;
  const _Indicators({
    required this.selectedindex,
    required this.place,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    for (var i = 0; i < place.urls.length; i++) {
      list.add(
        i == selectedindex
            ? _Indicator(place: place, isActive: true)
            : _Indicator(place: place, isActive: false),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}

class _Indicator extends StatelessWidget {
  final Place place;
  final bool isActive;
  const _Indicator({required this.place, required this.isActive, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return isActive
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 8,
            width: MediaQuery.of(context).size.width / place.urls.length,
            decoration: BoxDecoration(
              color: theme.canvasColor,
              borderRadius: BorderRadius.circular(8),
            ),
          )
        : const SizedBox.shrink();
  }
}

// верстка изображений объекта
class _ImageDetails extends StatelessWidget {
  final Place place;
  final int selectedindex;
  final PageController controller;

  const _ImageDetails({
    required this.place,
    required this.selectedindex,
    required this.controller,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 360,
          child: _SightPageView(
            place: place,
            selectedindex: selectedindex,
            controller: controller,
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel_rounded,
              color: theme.appBarTheme.backgroundColor,
              size: 40,
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: MediaQuery.of(context).size.width / 2 - 20,
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              color: theme.appBarTheme.backgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}

// верстка имени объекта
class _NameOfSight extends StatelessWidget {
  final Place place;

  const _NameOfSight(this.place, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24),
      alignment: Alignment.topLeft,
      child: Text(
        place.name,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.canvasColor,
          fontSize: 24,
        ),
      ),
    );
  }
}

// верстка типа объекта
class _TypeOfSight extends StatelessWidget {
  final Place place;

  const _TypeOfSight(this.place, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 2),
      alignment: Alignment.topLeft,
      child: Text(
        place.placeType,
        style: theme.textTheme.bodySmall
            ?.copyWith(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}

// верстка описания объекта
class _DetailsOfSight extends StatelessWidget {
  final Place place;

  const _DetailsOfSight(this.place, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
      alignment: Alignment.topLeft,
      child: Text(
        place.description,
        style: theme.textTheme.bodySmall
            ?.copyWith(color: Theme.of(context).canvasColor),
      ),
    );
  }
}

// верстка кнопки построить маршрут
class _BuildRouteButton extends StatelessWidget {
  final Place place;

  const _BuildRouteButton(this.place, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.planButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {
            debugPrint('Кнопка построить маршрут нажата.');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.play_arrow),
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
      ),
    );
  }
}

// верстка кнопок в избранное и запланировать
class _RowOfLowerButtons extends StatelessWidget {
  final Place place;

  const _RowOfLowerButtons(this.place, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            debugPrint('Кнопка запланировать нажата.');
          },
          child: Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: theme.primaryColorDark,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                AppStrings.planButtomText,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.primaryColorDark),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            debugPrint('Кнопка в избранное нажата.');
          },
          child: Row(
            children: [
              Icon(
                Icons.favorite,
                color: theme.canvasColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                AppStrings.favouriteButtonText,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.canvasColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
