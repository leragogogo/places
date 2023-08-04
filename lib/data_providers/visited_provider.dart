import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

class VisitedProvider extends ChangeNotifier {
  List<Place> visited = [];
  bool isVisitedEmpty = true;

  void changeState({
    required List<Place> newVisited,
    required bool newIsVisitedEmpty,
  }) {
    visited = newVisited;
    isVisitedEmpty = newIsVisitedEmpty;
    notifyListeners();
  }
}
