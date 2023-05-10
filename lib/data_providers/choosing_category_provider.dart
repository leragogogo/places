import 'package:flutter/material.dart';
import 'package:places/domain/categories.dart';

class ChoosingCategoryProvider extends ChangeNotifier {
  Categories? chosenCategory;
  void changeState({
    required Categories? newChosenCategory,
  }) {
    chosenCategory = newChosenCategory;
    notifyListeners();
  }
}

