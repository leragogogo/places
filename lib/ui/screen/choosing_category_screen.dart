import 'package:flutter/material.dart';
import 'package:places/data_providers/button_save_provider.dart';
import 'package:places/data_providers/choosing_category_provider.dart';
import 'package:places/domain/categories.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';
import 'package:provider/provider.dart';

class ChoosingCategoryScreen extends StatefulWidget {
  final Categories? lastChosenCategory;
  const ChoosingCategoryScreen({required this.lastChosenCategory, Key? key})
      : super(key: key);

  @override
  State<ChoosingCategoryScreen> createState() => _ChoosingCategoryScreenState();
}

class _ChoosingCategoryScreenState extends State<ChoosingCategoryScreen> {
  // состояние каждой категории(выбрана или нет)
  Map<Categories, bool> statesOfCategories = {
    Categories.hotel: false,
    Categories.restaurant: false,
    Categories.specialPlace: false,
    Categories.park: false,
    Categories.museum: false,
    Categories.cafe: false,
  };
  Categories? chosenCategory;

  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    chosenCategory = widget.lastChosenCategory;
    if (chosenCategory != null) {
      statesOfCategories[chosenCategory!] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    isButtonDisabled =
        Provider.of<ButtonSaveProvider>(context).isButtonDisabled;
    chosenCategory =
        Provider.of<ChoosingCategoryProvider>(context).chosenCategory;

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
            Navigator.pop(context, chosenCategory);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          _CategoryTiles(
            statesOfCategories: statesOfCategories,
          ),
          Expanded(
            child: BottomButton(
              text: AppStrings.saveButtonText,
              onPressed: isButtonDisabled
                  ? null
                  : () {
                      setState(() {
                        for (final category in statesOfCategories.keys) {
                          if (statesOfCategories[category]!) {
                            chosenCategory =
                                statesOfCategories[category]! ? category : null;
                          }
                        }
                      });
                      Provider.of<ChoosingCategoryProvider>(
                        context,
                        listen: false,
                      ).changeState(
                        newChosenCategory: chosenCategory,
                      );
                      Navigator.pop(context, chosenCategory);
                    },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTiles extends StatefulWidget {
  final Map<Categories, bool> statesOfCategories;
  const _CategoryTiles({required this.statesOfCategories, Key? key})
      : super(key: key);

  @override
  State<_CategoryTiles> createState() => _CategoryTilesState();
}

class _CategoryTilesState extends State<_CategoryTiles> {
  bool isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    final column = <Widget>[];
    for (final category in Categories.values) {
      column.add(_Category(
        category: category,
        isChosen: widget.statesOfCategories[category]!,
        onTap: () {
          setState(() {
            widget.statesOfCategories.forEach((key, value) {
              if (key != category) {
                widget.statesOfCategories.update(key, (value) => false);
              }
            });

            widget.statesOfCategories[category] =
                !widget.statesOfCategories[category]!;
            var count = 0;
            for (final category in widget.statesOfCategories.keys) {
              if (widget.statesOfCategories[category]!) {
                count += 1;
              }
            }
            isButtonDisabled = count == 0;
          });

          Provider.of<ButtonSaveProvider>(context, listen: false).changeState(
            newIsButtonDisabled: isButtonDisabled,
          );
        },
      ));
    }

    return Column(children: column);
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
