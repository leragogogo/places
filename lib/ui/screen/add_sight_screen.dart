import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data_providers/add_sight_provider.dart';
import 'package:places/data_providers/button_create_provider.dart';
import 'package:places/domain/categories.dart';
import 'package:places/ui/screen/choosing_category_screen.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';
import 'package:places/ui/screen/widgets/image_dialog.dart';
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

  bool stateOfCategory = false;

  FocusNode nameFocus = FocusNode();
  FocusNode latFocus = FocusNode();
  FocusNode lonFocus = FocusNode();
  FocusNode detailsFocus = FocusNode();

  bool isButtonDisabled = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  List<int> images = [];
  @override
  Widget build(BuildContext context) {
    final controllers = [
      nameController,
      latController,
      lonController,
      detailsController,
    ];

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
          onPressed: _resetState,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _AddImageWidget(
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (_) => const ImageDialog(),
                            );
                          },
                        ),
                        Row(
                          children: images.asMap().entries.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: _ImageWidget(
                                key: ValueKey(item.value),
                                delete: () {
                                  setState(() {
                                    images.remove(item.value);
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
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
                      await _openChoosingCategoryScreen(controllers);
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
                      _changeButtonState(controllers);
                      FocusScope.of(context).requestFocus(latFocus);
                    },
                    onTapOutside: (p) {
                      name = controllers[0].text;
                      _changeButtonState(controllers);
                      nameFocus.unfocus();
                    },
                    controller: nameController,
                    keyboardType: TextInputType.text,
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
                            width: (MediaQuery.of(context).size.width - 48) / 2,
                            child: _SightTextField(
                              focusNode: latFocus,
                              onSubmitted: (value) {
                                lat = double.tryParse(value);
                                _changeButtonState(controllers);
                                FocusScope.of(context).requestFocus(lonFocus);
                              },
                              onTapOutside: (p) {
                                lat = double.tryParse(controllers[1].text);
                                _changeButtonState(controllers);
                                latFocus.unfocus();
                              },
                              controller: latController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
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
                            width: (MediaQuery.of(context).size.width - 48) / 2,
                            child: _SightTextField(
                              focusNode: lonFocus,
                              onSubmitted: (value) {
                                lon = double.tryParse(value);
                                _changeButtonState(controllers);
                                FocusScope.of(context)
                                    .requestFocus(detailsFocus);
                              },
                              onTapOutside: (p) {
                                lon = double.tryParse(controllers[2].text);
                                _changeButtonState(controllers);
                                lonFocus.unfocus();
                              },
                              controller: lonController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
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
                      _changeButtonState(controllers);
                    },
                    onTapOutside: (p) {
                      details = controllers[3].text;
                      _changeButtonState(controllers);
                      detailsFocus.unfocus();
                    },
                    controller: detailsController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Expanded(
                  child: BottomButton(
                    text: AppStrings.createSightButtonText,
                    onPressed: isButtonDisabled
                        ? null
                        : () {
                            Provider.of<PlaceInteractor>(context, listen: false)
                                .addNewPlace(
                              newPlace: Place(
                                id: '1',
                                lat: lat ?? 0,
                                lon: lon ?? 0,
                                name: name ?? 'name',
                                urls: [
                                  'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
                                ],
                                placeType: category == null ? Categories.specialPlace.name : category!.name,//category!.name,
                                description: details ?? '',
                              ),
                            );
                            _resetState();
                          },
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Future<void> _openChoosingCategoryScreen(
    List<TextEditingController> controllers,
  ) async {
    category = await Navigator.push(
      context,
      MaterialPageRoute<Categories>(
        builder: (context) => ChoosingCategoryScreen(
          lastChosenCategory: category,
        ),
      ),
    );
    if (!mounted) return;
    stateOfCategory = category != null;
    _changeButtonState(controllers);

    Provider.of<AddSightProvider>(context, listen: false).changeState(
      newCategory: category,
    );
  }

  void _resetState() {
    category = null;
    isButtonDisabled = true;
    Provider.of<AddSightProvider>(context, listen: false).changeState(
      newCategory: category,
    );
    Provider.of<ButtonCreateProvider>(
      context,
      listen: false,
    ).changeState(
      newIsButtonDisabled: isButtonDisabled,
    );
    Navigator.pop(context);
  }

  void _changeButtonState(List<TextEditingController> controllers) {
    var c = 0;
    if (stateOfCategory) {
      c = 1;
    }

    for (final controller in controllers) {
      if (controller.text != '') {
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
  }
}

class _SightTextField extends StatelessWidget {
  final FocusNode focusNode;
  final void Function(String) onSubmitted;
  final Function(PointerDownEvent) onTapOutside;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _SightTextField({
    required this.focusNode,
    required this.onSubmitted,
    required this.onTapOutside,
    required this.controller,
    required this.keyboardType,
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
      onTapOutside: onTapOutside,
      controller: controller,
      keyboardType: keyboardType,
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

class _AddImageWidget extends StatelessWidget {
  final VoidCallback onTap;
  const _AddImageWidget({required this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.planButtonColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.plus,
            color: AppColors.planButtonColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final VoidCallback delete;
  const _ImageWidget({
    required this.delete,
    required Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      onDismissed: (direction) {
        delete();
      },
      direction: DismissDirection.vertical,
      child: Stack(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: Image.network(
                'https://b1.vpoxod.ru/ckeditor/1d/8f/28/149695.jpg',
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const CupertinoActivityIndicator(),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.clear_circled_solid,
              ),
              onPressed: delete,
            ),
          ),
        ],
      ),
    );
  }
}
