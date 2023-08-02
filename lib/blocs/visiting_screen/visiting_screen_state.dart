import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Базовый стейт экрана VisitingScreen.
abstract class VisitingScreenState extends Equatable {
  const VisitingScreenState();

  @override
  List<Object?> get props => [];
}

/// Пустое состояние экрана VisitingScreen.
class EmptyVisitingScreen extends VisitingScreenState {}

/// Состояние экрана VisitingScreen со списком любимых мест.
class VisitingScreenWithFavourites extends VisitingScreenState {
  final List<Place> favouritePlaces;

  const VisitingScreenWithFavourites({required this.favouritePlaces});

  @override
  List<Object?> get props => [favouritePlaces];
}
