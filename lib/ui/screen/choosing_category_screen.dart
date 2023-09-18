import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/data/model/categories.dart';
import 'package:places/redux/action/choosing_category_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/choosing_category_screen_state.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';

class ChoosingCategoryScreen extends StatefulWidget {
  final Categories? lastChosenCategory;
  const ChoosingCategoryScreen({required this.lastChosenCategory, Key? key})
      : super(key: key);

  @override
  State<ChoosingCategoryScreen> createState() => _ChoosingCategoryScreenState();
}

class _ChoosingCategoryScreenState extends State<ChoosingCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StoreConnector<AppState, ChoosingCategoryScreenState>(
        onInit: (store) {
      StoreProvider.of<AppState>(context)
          .dispatch(InitChoosingCategoryAction());
    }, builder: (BuildContext context, ChoosingCategoryScreenState vm) {
      if (vm is ChoosingCategoryScreenMainState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.choosingCategoryScreenTitle),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.canvasColor,
              ),
              onPressed: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(ExitFromChoosingCategoryScreenAction(context));
              },
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Expanded(
                flex: 2,
                child: ListView(
                  physics: Platform.isAndroid
                      ? const ClampingScrollPhysics()
                      : const BouncingScrollPhysics(),
                  children: Categories.values.map(
                    (category) {
                      return _Category(
                        category: category,
                        isChosen:
                            category == addSightRepository.candidateCategory,
                        onTap: () {
                          StoreProvider.of<AppState>(context)
                              .dispatch(ChooseCategoryAction(category));
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              Expanded(
                child: BottomButton(
                  text: AppStrings.saveButtonText,
                  onPressed: vm.isButtonDisabled
                      ? null
                      : () {
                          StoreProvider.of<AppState>(context).dispatch(
                              ReturnChosenCategoryAction(
                                  addSightRepository.candidateCategory!,
                                  context));
                        },
                ),
              ),
            ],
          ),
        );
      }
      return Container();
    }, converter: (store) {
      return store.state.choosingCategoryScreenState;
    });
  }
}

class _Category extends StatelessWidget {
  final Categories category;
  final bool isChosen;

  final VoidCallback onTap;
  const _Category({
    required this.category,
    required this.isChosen,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ListTile(
          leading: Text(
            category.name,
            style:
                theme.textTheme.bodyMedium?.copyWith(color: theme.canvasColor),
          ),
          trailing: isChosen
              ? Icon(
                  Icons.check,
                  size: 20.0,
                  color: AppColors.planButtonColor,
                )
              : const SizedBox.shrink(),
          onTap: onTap,
        ),
        const Divider(
          height: 20,
          indent: 16,
          endIndent: 16,
          thickness: 1,
        ),
      ],
    );
  }
}
