import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class SightDetailsScreen extends StatefulWidget {
  final Sight sight;

  const SightDetailsScreen(this.sight, {Key? key}) : super(key: key);

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
              sight: widget.sight,
              selectedindex: _currentPage,
              controller: _controller,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _NameOfSight(widget.sight),
                _TypeOfSight(widget.sight),
                _DetailsOfSight(widget.sight),
                _BuildRouteButton(widget.sight),
                Divider(
                  height: 39,
                  color: AppColors.ltTextColor,
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.8,
                ),
                _RowOfLowerButtons(widget.sight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SightPageView extends StatelessWidget {
  final Sight sight;
  final int selectedindex;
  final PageController controller;

  const _SightPageView({
    required this.sight,
    required this.selectedindex,
    required this.controller,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: controller,
          children: sight.images
              .map(
                (image) => ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    image,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : const CupertinoActivityIndicator(),
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
        ),
        Positioned(
          bottom: 0,
          left: selectedindex *
              (MediaQuery.of(context).size.width / sight.images.length),
          child: _Indicators(
            selectedindex: selectedindex,
            sight: sight,
          ),
        ),
      ],
    );
  }
}

class _Indicators extends StatelessWidget {
  final int selectedindex;
  final Sight sight;
  const _Indicators({
    required this.selectedindex,
    required this.sight,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];
    for (var i = 0; i < sight.images.length; i++) {
      list.add(
        i == selectedindex
            ? _Indicator(sight: sight, isActive: true)
            : _Indicator(sight: sight, isActive: false),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }
}

class _Indicator extends StatelessWidget {
  final Sight sight;
  final bool isActive;
  const _Indicator({required this.sight, required this.isActive, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return isActive
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 8,
            width: MediaQuery.of(context).size.width / sight.images.length,
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
  final Sight sight;
  final int selectedindex;
  final PageController controller;

  const _ImageDetails({
    required this.sight,
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
            sight: sight,
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
          color: theme.canvasColor,
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
        sight.type.name,
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
            ?.copyWith(color: Theme.of(context).canvasColor),
      ),
    );
  }
}

// верстка кнопки построить маршрут
class _BuildRouteButton extends StatelessWidget {
  final Sight sight;

  const _BuildRouteButton(this.sight, {Key? key}) : super(key: key);
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
  final Sight sight;

  const _RowOfLowerButtons(this.sight, {Key? key}) : super(key: key);
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
