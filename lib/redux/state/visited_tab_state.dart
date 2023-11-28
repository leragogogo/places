import 'package:places/data/model/place.dart';

abstract class VisitedPlacesTabState {}

class VisitedPlacesTabInitialState extends VisitedPlacesTabState {}

class VisitedPlacesTabDataState extends VisitedPlacesTabState {
  List<Place> visitedPlaces;
  VisitedPlacesTabDataState(this.visitedPlaces);
}

class VisitedPlacesTabEmptyState extends VisitedPlacesTabState {}
