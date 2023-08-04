import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_event.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_state.dart';
import 'package:places/data/repository/visiting_screen_repository.dart';

class VisitingScreenBloc extends Bloc<VisitingScreenEvent, VisitingScreenState> {
  final VisitingScreenRepository visitingScreenRepository;
  VisitingScreenBloc({required this.visitingScreenRepository})
      : super(
          VisitingScreenWithFavourites(
            favouritePlaces: visitingScreenRepository.favouritePlaces,
          ),
        ) {
    on<RemoveFavouritePlace>(_mapRemoveFavouritePlaceToState);
    on<DragFavouritePlace>(_mapDragFavouritePlaceToState);
  }

  void _mapRemoveFavouritePlaceToState(RemoveFavouritePlace event, Emitter<VisitingScreenState> emit) {
    visitingScreenRepository.favouritePlaces.remove(event.placeForRemoving);

    if (visitingScreenRepository.favouritePlaces.isNotEmpty) {
      emit(VisitingScreenWithFavourites(favouritePlaces: List.of(visitingScreenRepository.favouritePlaces)));
    } else {
      emit(EmptyVisitingScreen());
    }
  }

  void _mapDragFavouritePlaceToState(DragFavouritePlace event, Emitter<VisitingScreenState> emit) {
    var favouritePlaces = visitingScreenRepository.favouritePlaces;
    if (event.newIndex > event.oldIndex) event.newIndex -= 1;
    final item = favouritePlaces.removeAt(event.oldIndex);
    favouritePlaces.insert(event.newIndex, item);
    emit(VisitingScreenWithFavourites(
      favouritePlaces: List.of(favouritePlaces),
    ));
  }
}
