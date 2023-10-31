import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/data/model/categories.dart';
import 'package:places/redux/action/add_sight_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/ui/screen/choosing_category_screen.dart';
import 'package:redux/redux.dart';

class AddSightMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is OpenChoosingCategoryScreenAction) {
      await Navigator.push(
        action.context,
        MaterialPageRoute<Categories>(
          builder: (context) => ChoosingCategoryScreen(
            lastChosenCategory: addSightRepository.activeCategory,
          ),
        ),
      );
    }
    if (action is CreateNewPlaceAction) {
      try {
        final newPlace = Place(
            id: '1',
            lat: action.lat,
            lon: action.lon,
            name: action.name,
            urls: action.images,
            placeType: action.category.name,
            description: action.description);
        await placeRepository.addPlace(newPlace);
        store.dispatch(SuccesCreatingNewPlaceAction(newPlace, action.context));
      } catch (NetworkException) {
        store.dispatch(ErrorCreatingNewPlaceAction(action.context));
      }
    }
    if (action is UploadImageAction) {
      var imagePicker = ImagePicker();

      try {
        if (action.typeOfUploding == 1) {
          XFile? image = await imagePicker.pickImage(
              source: ImageSource.camera, imageQuality: 50);
          if (image != null) {
            store.dispatch(AddImageAction(image));
          }
          Navigator.of(action.context).pop();
        } else if (action.typeOfUploding == 2) {
          XFile? image = await imagePicker.pickImage(
              source: ImageSource.gallery, imageQuality: 50);
          if (image != null) {
            store.dispatch(AddImageAction(image));
          }
          Navigator.of(action.context).pop();
        } else {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            var image = XFile(result.files.single.path!);
            store.dispatch(AddImageAction(image));
          }
          Navigator.of(action.context).pop();
        }
      } catch (_) {
        store.dispatch(UploadImageErrorAction(action.context));
      }
    }
    next(action);
  }
}
