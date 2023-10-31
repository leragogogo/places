import 'package:places/redux/action/add_sight_screen_action.dart';
import 'package:places/redux/action/choosing_category_screen_action.dart';
import 'package:places/redux/action/filters_screen_action.dart';
import 'package:places/redux/action/search_screen_action.dart';
import 'package:places/redux/action/sight_list_screen_action.dart';
import 'package:places/redux/action/favourite_tab_action.dart';
import 'package:places/redux/reducer/add_sight_screen_reducer.dart';
import 'package:places/redux/reducer/choosing_category_screen_reducer.dart';
import 'package:places/redux/reducer/filters_screen_reducer.dart';
import 'package:places/redux/reducer/search_screen_reducer.dart';
import 'package:places/redux/reducer/sight_list_screen_reducer.dart';
import 'package:places/redux/reducer/favourite_tab_reducer.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  /// SearchScreen
  TypedReducer<AppState, RemoveItemFromHistoryAction>(
      removeItemFromHistoryReducer),
  TypedReducer<AppState, RemoveAllItemsFromHistory>(
      removeAllItemsFromHistoryReducer),
  TypedReducer<AppState, SearchTextWasUpdatedAction>(
      searchTextWasUpdatedReducer),
  TypedReducer<AppState, TapOnMiniCardSight>(
      tapOnMiniCardSightReducer),
  TypedReducer<AppState, InitSearchScreenAction>(
      initSearchScreenReducer),

  /// SightListScreen
  TypedReducer<AppState, AddSightToFavouriteAction>(addSightToFavouriteReducer),
  TypedReducer<AppState, OpenSearchScreenAction>(openSearchScreenReducer),
  TypedReducer<AppState, OpenFiltersScreenAction>(openFiltersScreenReducer),
  TypedReducer<AppState, LoadSightsAction>(loadSightsReducer),
  TypedReducer<AppState, ResultSightsAction>(resultSightsReducer),
  TypedReducer<AppState, ErrorAction>(errorReducer),

  /// FavouriteTab
  TypedReducer<AppState, RemoveFavouritePlaceAction>(
      removeFavouritePlaceReducer),
  TypedReducer<AppState, InitFavouriteTabAction>(initFavouriteTabReducer),
  TypedReducer<AppState, DragFavouritePlaceAction>(dragFavouritePlaceReducer),
  TypedReducer<AppState, PlanVisitOfPlaceAction>(planVisitOfPlaceReducer),

  /// FiltersScreen
  TypedReducer<AppState, ClickOnCategoryAction>(clickOnCategoryReducer),
  TypedReducer<AppState, ChangeRangeOfSliderAction>(changeRangeOfSliderReducer),
  TypedReducer<AppState, ShowResultAction>(showResultReducer),
  TypedReducer<AppState, ExitFromFiltersScreenAction>(
      exitFromFiltersScreenReducer),
  TypedReducer<AppState, ClearSelectionsAction>(clearSelectionsReducer),
  TypedReducer<AppState, InitFiltersScreenAction>(initFiltersScreenReducer),

  // AddSightScreen
  TypedReducer<AppState, FillNameAction>(fillNameReducer),
  TypedReducer<AppState, FillLatAction>(fillLatReducer),
  TypedReducer<AppState, FillLonAction>(fillLonReducer),
  TypedReducer<AppState, ChooseLocationOnMapAction>(chooseLocationOnMapReducer),
  TypedReducer<AppState, FillDescriptionAction>(fillDescriptionReducer),
  TypedReducer<AppState, CreateNewPlaceAction>(createNewPlaceReducer),
  TypedReducer<AppState, ExitFromAddSightScreenAction>(
      exitFromAddSightScreenReducer),
  TypedReducer<AppState, ChooseImagesAction>(chooseImagesReducer),
  TypedReducer<AppState, RemoveImageAction>(removeImageReducer),
  TypedReducer<AppState, OpenChoosingCategoryScreenAction>(
      openChoosingCategoryScreenReducer),
  TypedReducer<AppState, InitAddSightScreenAction>(initAddSightScreenReducer),
  TypedReducer<AppState, SuccesCreatingNewPlaceAction>(
      succesCreatingNewPlaceReducer),
  TypedReducer<AppState, ErrorCreatingNewPlaceAction>(
      errorCreatingNewPlaceReducer),
  TypedReducer<AppState, UploadImageAction>(
      uploadImageReducer),
  TypedReducer<AppState, AddImageAction>(
      addImageReducer),
  TypedReducer<AppState, UploadImageErrorAction>(
      uploadImageErrorReducer),
  

  // ChoosingCategoryScreen
  TypedReducer<AppState, InitChoosingCategoryAction>(
      initChoosingCategoryReducer),
  TypedReducer<AppState, ChooseCategoryAction>(chooseCategoryReducer),
  TypedReducer<AppState, ExitFromChoosingCategoryScreenAction>(
      exitFromChoosingCategoryScreenReducer),
  TypedReducer<AppState, ReturnChosenCategoryAction>(
      returnChosenCategoryReducer),
]);
