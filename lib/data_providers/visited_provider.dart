import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

class VisitedProvider extends ChangeNotifier {
  List<Sight> visited = [mocks[1], mocks[2]];
  bool isVisitedEmpty = false;
  void changeState({
    required List<Sight> newVisited,
    required bool newIsVisitedEmpty,
  }) {
    visited = newVisited;
    isVisitedEmpty = newIsVisitedEmpty;
    notifyListeners();
  }
}
