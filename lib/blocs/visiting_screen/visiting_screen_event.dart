import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовый эвент экрана VisitingScreen.
abstract class VisitingScreenEvent extends Equatable {
  const VisitingScreenEvent();

  @override
  List<Object?> get props => [];
}

/// Эвент удаление места из списка любимых.
class RemoveFavouritePlace extends VisitingScreenEvent {
  final Place placeForRemoving;
  const RemoveFavouritePlace({required this.placeForRemoving});

  @override
  List<Object?> get props => [placeForRemoving];
}

/// Эвент перемещения места в списке любимых.
class DragFavouritePlace extends VisitingScreenEvent {
  final int oldIndex;
  int newIndex;
  DragFavouritePlace({required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}
