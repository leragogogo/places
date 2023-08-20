import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/place.dart';
import 'package:places/domain/categories.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class AddSightScreenWidgetModel extends WidgetModel {
  AddSightScreenWidgetModel(this._placeInteractor)
      : super(const WidgetModelDependencies());

  static AddSightScreenWidgetModel builder(BuildContext context) {
    return AddSightScreenWidgetModel(context.read<PlaceInteractor>());
  }

  final PlaceInteractor _placeInteractor;
  final isCreateButtonDisabled = StreamedState<bool>(true);
  final category = StreamedState<Categories?>(null);
  final name = StreamedState<String>('');
  final lat = StreamedState<double?>(null);
  final lon = StreamedState<double?>(null);
  final desc = StreamedState<String>('');

  void selectCategory({required Categories newCategory}) {
    category.accept(newCategory);
    _updateButtonState();
  }

  void inputName({required String newName}) {
    name.accept(newName);
    _updateButtonState();
  }

  void inputLat({required double newLat}) {
    lat.accept(newLat);
    _updateButtonState();
  }

  void inputLon({required double newLon}) {
    lon.accept(newLon);
    _updateButtonState();
  }

  void inputDesc({required String newDesc}) {
    desc.accept(newDesc);
    _updateButtonState();
  }

  void _updateButtonState() {
    if (name.value.isNotEmpty &&
        lat.value != null &&
        lon.value != null &&
        desc.value.isNotEmpty &&
        category.value != null)
      isCreateButtonDisabled.accept(false);
    else
      isCreateButtonDisabled.accept(true);
  }

  void addPlace() {
    final newPlace = Place(
        id: '1',
        lat: lat.value ?? 0,
        lon: lon.value ?? 0,
        name: name.value,
        urls: [
          'https://avatars.mds.yandex.net/get-altay/5235198/2a0000017afdeefb6009b7fd234b65744604/XXXL',
        ],
        placeType: category.value == null
            ? Categories.specialPlace.name
            : category.value!.name,
        description: desc.value);
    _placeInteractor.addNewPlace(newPlace: newPlace);
  }
}
