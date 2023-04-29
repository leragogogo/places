import 'package:flutter/material.dart';

class ButtonSaveProvider extends ChangeNotifier {
  bool isButtonDisabled = true;
  void changeState({
    required bool newIsButtonDisabled,
  }) {
    isButtonDisabled = newIsButtonDisabled;
    notifyListeners();
  }
}
