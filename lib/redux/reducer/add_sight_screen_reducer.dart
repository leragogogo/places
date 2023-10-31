import 'package:flutter/material.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/data/model/location.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/add_sight_screen_action.dart';
import 'package:places/redux/state/add_sight_screen_state.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/sight_list_screen_state.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/error_alert_dialog.dart';
import 'package:places/ui/screen/widgets/image_dialog.dart';

AppState initAddSightScreenReducer(
    AppState state, InitAddSightScreenAction action) {
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}

AppState chooseImagesReducer(AppState state, ChooseImagesAction action) {
  showDialog<void>(
    context: action.context,
    builder: (_) => const ImageDialog(),
  );
  return state;
}

AppState uploadImageReducer(AppState state, UploadImageAction action) {
  return state;
}

AppState removeImageReducer(AppState state, RemoveImageAction action) {
  addSightRepository.images.remove(action.imageForRemoval);
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}

AppState openChoosingCategoryScreenReducer(
    AppState state, OpenChoosingCategoryScreenAction action) {
  return state;
}

AppState addImageReducer(AppState state, AddImageAction action) {
  addSightRepository.images.add(action.image);

  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}

AppState fillNameReducer(AppState state, FillNameAction action) {
  addSightRepository.name = action.name;
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}

AppState fillLatReducer(AppState state, FillLatAction action) {
  addSightRepository.lat = action.lat;
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}

AppState fillLonReducer(AppState state, FillLonAction action) {
  addSightRepository.lon = action.lon;
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}

AppState chooseLocationOnMapReducer(
    AppState state, ChooseLocationOnMapAction action) {
  return state;
}

AppState fillDescriptionReducer(AppState state, FillDescriptionAction action) {
  addSightRepository.details = action.description;
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}

AppState createNewPlaceReducer(AppState state, CreateNewPlaceAction action) {
  return state;
}

AppState succesCreatingNewPlaceReducer(
    AppState state, SuccesCreatingNewPlaceAction action) {
  placeRepository.places.add(action.newPlace);
  final distance = calcDistance(
      Location(lat: action.newPlace.lat, lon: action.newPlace.lon),
      getUserLocation());
  var selectedCategories = getSelectedCategories();
  if (selectedCategories
          .map((e) => e.type)
          .toList()
          .contains(action.newPlace.placeType) &&
      distance >= points[filterRepository.activeRadius.start.round()]! &&
      distance <= points[filterRepository.activeRadius.end.round()]!) {
    var prevState = state.sightListScreenState as SightListScreenDataState;
    prevState.places.add(action.newPlace);
    Navigator.pop(action.context);
    return state.cloneWith(
        sightListScreenState: SightListScreenDataState(prevState.places));
  }

  Navigator.pop(action.context);
  return state;
}

AppState errorCreatingNewPlaceReducer(
    AppState state, ErrorCreatingNewPlaceAction action) {
  showDialog<void>(
    context: action.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ErrorAlertDialog(
          firstText: AppStrings.addSightErrorText1,
          secondText: AppStrings.addSightErrorText2,
          exitFromDialog: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
    },
  );
  return state;
}

AppState uploadImageErrorReducer(
    AppState state, UploadImageErrorAction action) {
  showDialog<void>(
    context: action.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ErrorAlertDialog(
        firstText: AppStrings.uploadImageText1,
        secondText: AppStrings.uploadImageText2,
        exitFromDialog: () {
          Navigator.of(context).pop();
        },
      );
    },
  );
  return state;
}

AppState exitFromAddSightScreenReducer(
    AppState state, ExitFromAddSightScreenAction action) {
  addSightRepository.images = [];
  addSightRepository.activeCategory = null;
  addSightRepository.name = null;
  addSightRepository.lat = null;
  addSightRepository.lon = null;
  addSightRepository.details = null;
  Navigator.pop(action.context);
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          false));
}
