import 'dart:io';

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
                    isChosen: statesOfCategories[category]!,
                    onTap: () {
                      _onCategoryTap(category);
                    },
                  );
                },
              ).toList(),
            ),
          ),
          Expanded(
            child: BottomButton(
              text: AppStrings.saveButtonText,
              onPressed: isButtonDisabled ? null : _bottomButtonOnPressed,
            ),
          ),
        ],
      ),
    );
  }

  void _bottomButtonOnPressed() {
    setState(() {
      for (final category in statesOfCategories.keys) {
        if (statesOfCategories[category]!) {
          chosenCategory = statesOfCategories[category]! ? category : null;
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
  }

  void _onCategoryTap(Categories category) {
    setState(() {
      statesOfCategories.forEach((key, value) {
        if (key != category) {
          statesOfCategories.update(key, (value) => false);
        }
      });

      statesOfCategories[category] = !statesOfCategories[category]!;
      var count = 0;
      for (final category in statesOfCategories.keys) {
        if (statesOfCategories[category]!) {
          count += 1;
        }
      }
      isButtonDisabled = count == 0;
    });

    Provider.of<ButtonSaveProvider>(context, listen: false).changeState(
      newIsButtonDisabled: isButtonDisabled,
    );
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
