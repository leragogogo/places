import 'package:flutter/material.dart';

class ButtonCreateProvider extends ChangeNotifier {
  bool isButtonDisabled = true;
  void changeState({
    required bool newIsButtonDisabled,
  }) {
    isButtonDisabled = newIsButtonDisabled;
    notifyListeners();
  }
}