import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/categories.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen_wm.dart';
import 'package:places/ui/screen/choosing_category_screen.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';
import 'package:places/ui/screen/widgets/image_dialog.dart';
import 'package:relation/relation.dart';

class AddSightScreen extends CoreMwwmWidget {
  const AddSightScreen({
    Key? key,
    WidgetModelBuilder? widgetModelBuilder,
  }) : super(key: key, widgetModelBuilder: AddSightScreenWidgetModel.builder);

  @override
  State<StatefulWidget> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends WidgetState<AddSightScreenWidgetModel> {
  FocusNode nameFocus = FocusNode();
  FocusNode latFocus = FocusNode();
  FocusNode lonFocus = FocusNode();
  FocusNode detailsFocus = FocusNode();

  List<int> images = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controllers = [
      nameController,
      latController,
      lonController,
      detailsController,
    ];
    final theme = Theme.of(context);

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
        automaticallyImplyLeading: false,
      ),
      body: StreamedStateBuilder<bool>(
          streamedState: wm.isCreateButtonDisabled,
          builder: (contex, data) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),

                      // Выбор картинок.
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

                      // Поле выбора категории
                      StreamedStateBuilder<Categories?>(
                        streamedState: wm.category,
                        builder: (context, data) {
                          return ListTile(
                            leading: Text(
                              wm.category.value == null
                                  ? 'Не выбрано'
                                  : wm.category.value!.name,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: theme.canvasColor),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                final category = await Navigator.push(
                                  context,
                                  MaterialPageRoute<Categories>(
                                    builder: (context) =>
                                        ChoosingCategoryScreen(
                                      lastChosenCategory: wm.category.value,
                                    ),
                                  ),
                                );
                                if (category != null) {
                                  wm.selectCategory(newCategory: category);
                                }
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                              color: theme.canvasColor,
                            ),
                          );
                        },
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

                      // Текстовое поле ввода названия
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: _SightTextField(
                          focusNode: nameFocus,
                          onSubmitted: (value) {
                            wm.inputName(newName: value);
                            FocusScope.of(context).requestFocus(latFocus);
                          },
                          onTapOutside: (p) {
                            wm.inputName(newName: controllers[0].text);
                            nameFocus.unfocus();
                          },
                          controller: nameController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      // Текстовые поля выбора широты и долготы
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
                                  width:
                                      (MediaQuery.of(context).size.width - 48) /
                                          2,
                                  child: _SightTextField(
                                    focusNode: latFocus,
                                    onSubmitted: (value) {
                                      wm.inputLat(
                                          newLat: double.tryParse(value) ?? 0);
                                      FocusScope.of(context)
                                          .requestFocus(lonFocus);
                                    },
                                    onTapOutside: (p) {
                                      wm.inputLat(
                                          newLat: double.tryParse(
                                                  controllers[1].text) ??
                                              0);

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
                                  width:
                                      (MediaQuery.of(context).size.width - 48) /
                                          2,
                                  child: _SightTextField(
                                    focusNode: lonFocus,
                                    onSubmitted: (value) {
                                      wm.inputLon(
                                          newLon: double.tryParse(value) ?? 0);
                                      FocusScope.of(context)
                                          .requestFocus(detailsFocus);
                                    },
                                    onTapOutside: (p) {
                                      wm.inputLon(
                                          newLon: double.tryParse(
                                                  controllers[2].text) ??
                                              0);

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

                      // Кнопка выбора местоположения на карте
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

                      // Текстовое поле ввода описания
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: _SightTextField(
                          focusNode: detailsFocus,
                          onSubmitted: (value) {
                            wm.inputDesc(newDesc: value);
                          },
                          onTapOutside: (p) {
                            wm.inputDesc(newDesc: controllers[3].text);
                            detailsFocus.unfocus();
                          },
                          controller: detailsController,
                          keyboardType: TextInputType.text,
                        ),
                      ),

                      // Кнопка создания места
                      Expanded(
                        child: BottomButton(
                          text: AppStrings.createSightButtonText,
                          onPressed: wm.isCreateButtonDisabled.value
                              ? null
                              : () {
                                  wm.addPlace();
                                  Navigator.pop(context);
                                },
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            );
          }),
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
