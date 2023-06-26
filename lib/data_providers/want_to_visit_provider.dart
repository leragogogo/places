import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

class WantToVisitProvider extends ChangeNotifier {
  List<Place> wantToVisit = [];
  bool isWantToVisitEmpty = true;
  void changeState({
    required List<Place> newWantToVisit,
    required bool newIsWantToVisitEmpty,
  }) {
    wantToVisit = newWantToVisit;
    isWantToVisitEmpty = newIsWantToVisitEmpty;
    notifyListeners();
  }
}
