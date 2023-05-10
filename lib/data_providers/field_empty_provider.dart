import 'package:flutter/cupertino.dart';

class FieldEmptyProvider extends ChangeNotifier{
  bool isFieldEmpty = true;
  void changeState({
    required bool newIsFieldEmpty,
  }) {
    isFieldEmpty = newIsFieldEmpty;

    notifyListeners();
  }
}