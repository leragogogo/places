import 'package:flutter/material.dart';

class FiltersProvider extends ChangeNotifier {
  int sightCount = 0;
  bool isButtonDisabled = true;
  void changeState({
    required int newSightCount,
    required bool newIsButtonDisabled,
  }) {
    sightCount = newSightCount;
    isButtonDisabled = newIsButtonDisabled;
    notifyListeners();
  }
}
