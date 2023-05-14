import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

class WantToVisitProvider extends ChangeNotifier {
  List<Sight> wantToVisit = [mocks[0], mocks[3]];
  bool isWantToVisitEmpty = false;
  void changeState({
    required List<Sight> newWantToVisit,
    required bool newIsWantToVisitEmpty,
  }) {
    wantToVisit = newWantToVisit;
    isWantToVisitEmpty = newIsWantToVisitEmpty;
    notifyListeners();
  }
}
