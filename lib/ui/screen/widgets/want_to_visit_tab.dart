import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_event.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data_providers/want_to_visit_provider.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/empty_screen.dart';
import 'package:places/ui/screen/widgets/sight_card_visited.dart';
import 'package:provider/provider.dart';

class WantToVisitTab extends StatefulWidget {
  const WantToVisitTab({super.key});

  @override
  State<StatefulWidget> createState() => _WantToVisitTabState();
}

class _WantToVisitTabState extends State<WantToVisitTab> {
  DateTime? _chosenDateTime;

  List<Place> _wantToVisit = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    _wantToVisit = Provider.of<WantToVisitProvider>(context).wantToVisit;

    return BlocBuilder<VisitingScreenBloc, VisitingScreenState>(
        builder: (context, state) {
      return state is VisitingScreenWithFavourites
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ReorderableListView(
                physics: Platform.isAndroid
                    ? const ClampingScrollPhysics()
                    : const BouncingScrollPhysics(),
                proxyDecorator: (child, index, animation) => Material(
                  type: MaterialType.transparency,
                  child: child,
                ),
                onReorder: (oldIndex, newIndex) {
                  context.read<VisitingScreenBloc>().add(DragFavouritePlace(
                      oldIndex: oldIndex, newIndex: newIndex));
                  Provider.of<WantToVisitProvider>(
                    context,
                    listen: false,
                  ).changeState(
                    newWantToVisit: state.favouritePlaces,
                  );
                },
                children: _wantToVisit
                    .asMap()
                    .entries
                    .map((i) => VisitingSightCard(
                          key: ObjectKey(i.value),
                          sight: i.value,
                          deleteFromList: () {
                            context.read<VisitingScreenBloc>().add(
                                RemoveFavouritePlace(
                                    placeForRemoving: i.value));
                            Provider.of<WantToVisitProvider>(
                              context,
                              listen: false,
                            ).changeState(
                              newWantToVisit: state.favouritePlaces,
                            );
                          },
                          lowerText: Text(
                            AppStrings.wantToVisitText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.planButtonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leftIcon: const ImageIcon(
                            AssetImage(AppAssets.calendarAsset),
                            color: Colors.white,
                          ),
                          leftIconOnPressed: () {
                            Platform.isAndroid
                                ? _showAndroidPicker()
                                : _showIOSPicker();
                          },
                        ))
                    .toList(),
              ))
          : const EmptyScreen(
              path: AppAssets.wantToVisitedEmpty,
              text: AppStrings.wantToVisetedEmptyText,
            );
    });
  }

  void _showAndroidPicker() {
    final theme = Theme.of(context);
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.planButtonColor,
              onSurface: theme.canvasColor,
            ),
            dialogBackgroundColor: theme.appBarTheme.backgroundColor,
          ),
          child: child!,
        );
      },
    );
  }

  void _showIOSPicker() {
    final theme = Theme.of(context);
    showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: theme.appBarTheme.backgroundColor,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          theme.textTheme.bodyMedium?.copyWith(
                        color: theme.canvasColor,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: CupertinoButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: AppColors.planButtonColor,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
