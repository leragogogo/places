import 'package:flutter/material.dart';
import 'package:places/data_providers/add_sight_provider.dart';
import 'package:places/data_providers/button_create_provider.dart';
import 'package:places/domain/categories.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/choosing_category_screen.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';
import 'package:provider/provider.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

String replaceNull(Categories? category) {
  return category == null ? AppStrings.unchosenCategoryText : category.name;
}

class _AddSightScreenState extends State<AddSightScreen> {
  Categories? category;
  String? name;
  double? lat;
  double? lon;
  String? details;

  Map<String, bool> statesOfFields = {
    'name': false,
    'lat': false,
    'lon': false,
    'details': false,
    'category': false,
  };

  FocusNode nameFocus = FocusNode();
  FocusNode latFocus = FocusNode();
  FocusNode lonFocus = FocusNode();
  FocusNode detailsFocus = FocusNode();

  bool isButtonDisabled = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    isButtonDisabled =
        Provider.of<ButtonCreateProvider>(context).isButtonDisabled;
    category = Provider.of<AddSightProvider>(context).category;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addSightScreenTitle),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.canvasColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: _Label(text: AppStrings.categoryOfNewSightText),
          ),
          ListTile(
            leading: Text(
              replaceNull(category),
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.canvasColor),
            ),
            trailing: IconButton(
              onPressed: () async {
                category = await Navigator.push(
                  context,
                  MaterialPageRoute<Categories>(
                    builder: (context) => ChoosingCategoryScreen(
                      lastChosenCategory: category,
                    ),
                  ),
                );
                if (!mounted) return;
                if (category != null) {
                  statesOfFields['category'] = true;
                } else {
                  statesOfFields['category'] = false;
                }
                var c = 0;
                for (final field in statesOfFields.keys) {
                  if (statesOfFields[field]!) {
                    c += 1;
                  }
                }
                isButtonDisabled = c != 5;
                Provider.of<ButtonCreateProvider>(context, listen: false)
                    .changeState(
                  newIsButtonDisabled: isButtonDisabled,
                );

                Provider.of<AddSightProvider>(context, listen: false)
                    .changeState(
                  newCategory: category,
                );
              },
              icon: const Icon(Icons.arrow_forward_ios),
              color: theme.canvasColor,
            ),
          ),
          const Divider(
            height: 28,
            indent: 16,
            endIndent: 16,
            thickness: 1,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: _Label(text: AppStrings.nameFieldText),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: _SightTextField(
              focusNode: nameFocus,
              onSubmitted: (value) {
                name = value;
                if (name != '') {
                  statesOfFields['name'] = true;
                } else {
                  statesOfFields['name'] = false;
                }
                var c = 0;
                for (final field in statesOfFields.keys) {
                  if (statesOfFields[field]!) {
                    c += 1;
                  }
                }
                isButtonDisabled = c != 5;
                Provider.of<ButtonCreateProvider>(context, listen: false)
                    .changeState(
                  newIsButtonDisabled: isButtonDisabled,
                );
                FocusScope.of(context).requestFocus(latFocus);
              },
              
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    const _Label(text: AppStrings.latFieldText),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 156,
                      child: _SightTextField(
                        focusNode: latFocus,
                        onSubmitted: (value) {
                          lat = double.tryParse(value);
                          if (lat != null) {
                            statesOfFields['lat'] = true;
                          } else {
                            statesOfFields['lat'] = false;
                          }
                          var c = 0;
                          for (final field in statesOfFields.keys) {
                            if (statesOfFields[field]!) {
                              c += 1;
                            }
                          }
                          isButtonDisabled = c != 5;
                          Provider.of<ButtonCreateProvider>(
                            context,
                            listen: false,
                          ).changeState(
                            newIsButtonDisabled: isButtonDisabled,
                          );
                          FocusScope.of(context).requestFocus(lonFocus);
                        },
                        
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    const _Label(text: AppStrings.lonFieldText),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 156,
                      child: _SightTextField(
                        focusNode: lonFocus,
                        onSubmitted: (value) {
                          lon = double.tryParse(value);
                          if (lon != null) {
                            statesOfFields['lon'] = true;
                          } else {
                            statesOfFields['lon'] = false;
                          }
                          var c = 0;
                          for (final field in statesOfFields.keys) {
                            if (statesOfFields[field]!) {
                              c += 1;
                            }
                          }
                          isButtonDisabled = c != 5;
                          Provider.of<ButtonCreateProvider>(
                            context,
                            listen: false,
                          ).changeState(
                            newIsButtonDisabled: isButtonDisabled,
                          );
                          FocusScope.of(context).requestFocus(detailsFocus);
                        },
                        
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.pointOnMapText,
                style: TextStyle(
                  color: AppColors.planButtonColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 37,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: _Label(text: AppStrings.detailsFieldText),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: _SightTextField(
              focusNode: detailsFocus,
              onSubmitted: (value) {
                details = value;
                if (details != '') {
                  statesOfFields['details'] = true;
                } else {
                  statesOfFields['details'] = false;
                }
                var c = 0;
                for (final field in statesOfFields.keys) {
                  if (statesOfFields[field]!) {
                    c += 1;
                  }
                }
                isButtonDisabled = c != 5;
                Provider.of<ButtonCreateProvider>(context, listen: false)
                    .changeState(
                  newIsButtonDisabled: isButtonDisabled,
                );
              },
            ),
          ),
          Expanded(
            child: BottomButton(
              text: AppStrings.createSightButtonText,
              onPressed: isButtonDisabled
                  ? null
                  : () {
                      mocks.add(
                        Sight(
                          name: name!,
                          lat: lat!,
                          lon: lon!,
                          url:
                              'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
                          details: details!,
                          type: category!,
                        ),
                      );
                      Navigator.pop(context);
                    },
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class _SightTextField extends StatelessWidget {
  final FocusNode focusNode;
  final void Function(String) onSubmitted;

  const _SightTextField({
    required this.focusNode,
    required this.onSubmitted,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      focusNode: focusNode,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.canvasColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.planButtonColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onSubmitted: onSubmitted,
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: theme.textTheme.bodyMedium
            ?.copyWith(color: theme.primaryColorDark, fontSize: 12),
      ),
    );
  }
}
