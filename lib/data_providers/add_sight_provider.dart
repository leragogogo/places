import 'package:flutter/material.dart';
import 'package:places/domain/categories.dart';

class AddSightProvider extends ChangeNotifier {
  Categories? category;
  void changeState({
    required Categories? newCategory,
  }) {
    category = newCategory;

    notifyListeners();
  }
}
