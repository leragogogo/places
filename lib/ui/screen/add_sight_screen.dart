import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/data/model/categories.dart';
import 'package:places/redux/action/add_sight_screen_action.dart';
import 'package:places/redux/state/add_sight_screen_state.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

String replaceNull(Categories? category) {
  return category == null ? AppStrings.unchosenCategoryText : category.name;
}

class _AddSightScreenState extends State<AddSightScreen> {
  FocusNode nameFocus = FocusNode();
  FocusNode latFocus = FocusNode();
  FocusNode lonFocus = FocusNode();
  FocusNode detailsFocus = FocusNode();

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

    return StoreConnector<AppState, AddSightScreenState>(onInit: (store) {
      store.dispatch(InitAddSightScreenAction());
    }, builder: (BuildContext context, AddSightScreenState vm) {
      if (vm is AddSightScreenMainState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.addSightScreenTitle),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.canvasColor,
              ),
              onPressed: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(ExitFromAddSightScreenAction(context));
              },
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
                                StoreProvider.of<AppState>(context)
                                    .dispatch(ChooseImagesAction(context));
                              },
                            ),
                            Row(
                              children: vm.images.asMap().entries.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: _ImageWidget(
                                    image: item.value ??
                                        XFile(AppAssets.placeholderAsset),
                                    key: ValueKey(item.value),
                                    delete: () {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(
                                              RemoveImageAction(item.value));
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
                        replaceNull(vm.category),
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.canvasColor),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(
                              OpenChoosingCategoryScreenAction(context));
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
                          StoreProvider.of<AppState>(context)
                              .dispatch(FillNameAction(value));
                          FocusScope.of(context).requestFocus(latFocus);
                        },
                        onTapOutside: (p) {
                          if (addSightRepository.name != controllers[0].text) {
                            StoreProvider.of<AppState>(context)
                                .dispatch(FillNameAction(controllers[0].text));
                          }
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
                                width:
                                    (MediaQuery.of(context).size.width - 48) /
                                        2,
                                child: _SightTextField(
                                  focusNode: latFocus,
                                  onSubmitted: (value) {
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(FillLatAction(
                                            double.tryParse(value)!));
                                    FocusScope.of(context)
                                        .requestFocus(lonFocus);
                                  },
                                  onTapOutside: (p) {
                                    if (addSightRepository.lat !=
                                        double.tryParse(controllers[1].text)) {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(FillLatAction(
                                              double.tryParse(
                                                  controllers[1].text)!));
                                    }
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
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(FillLonAction(
                                            double.tryParse(value)!));
                                    FocusScope.of(context)
                                        .requestFocus(detailsFocus);
                                  },
                                  onTapOutside: (p) {
                                    if (addSightRepository.lon !=
                                        double.tryParse(controllers[2].text)) {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(FillLonAction(
                                              double.tryParse(
                                                  controllers[2].text)!));
                                    }
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
                          StoreProvider.of<AppState>(context)
                              .dispatch(FillDescriptionAction(value));
                        },
                        onTapOutside: (p) {
                          if (addSightRepository.details !=
                              controllers[3].text) {
                            StoreProvider.of<AppState>(context).dispatch(
                                FillDescriptionAction(controllers[3].text));
                          }
                          detailsFocus.unfocus();
                        },
                        controller: detailsController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      child: BottomButton(
                          text: AppStrings.createSightButtonText,
                          onPressed: vm.isAllFieldsFilled
                              ? () {
                                  StoreProvider.of<AppState>(context).dispatch(
                                      CreateNewPlaceAction(
                                          [
                                        'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
                                      ],
                                          vm.category ??
                                              Categories.specialPlace,
                                          vm.name ?? 'name',
                                          vm.lat ?? 0,
                                          vm.lon ?? 0,
                                          vm.details ?? '',
                                          context));
                                }
                              : null),
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

      return Container();
    }, converter: (store) {
      return store.state.addSightScreenState;
    });
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
  final XFile image;
  final VoidCallback delete;
  const _ImageWidget({
    required this.image,
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
              child: Image.file(
                File(image.path),
                fit: BoxFit.fitHeight,
              ), /*Image.network(
                image.//'https://b1.vpoxod.ru/ckeditor/1d/8f/28/149695.jpg',
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const CupertinoActivityIndicator(),
                fit: BoxFit.fitHeight,
              ),*/
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
