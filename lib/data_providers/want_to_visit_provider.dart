import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/widgets/store.dart';

class WantToVisitProvider extends ChangeNotifier {
  List<Place> wantToVisit = [
    store.places[0],
    store.places[1],
    store.places[2],
  ];
  void changeState({
    required List<Place> newWantToVisit,
  }) {
    wantToVisit = newWantToVisit;
    notifyListeners();
  }
}
