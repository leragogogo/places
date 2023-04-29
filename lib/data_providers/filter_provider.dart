import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

class FiltersProvider extends ChangeNotifier {
  int sightCount = 0;
  bool isButtonDisabled = true;
  List<Sight> mocksWithFilters = mocks;
  void changeState({
    required int newSightCount,
    required bool newIsButtonDisabled,
    required List<Sight> newMocksWithFilters,
  }) {
    sightCount = newSightCount;
    isButtonDisabled = newIsButtonDisabled;
    mocksWithFilters = newMocksWithFilters;
    notifyListeners();
  }
}
