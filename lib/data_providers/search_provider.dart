import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  List<Widget> searchList = [];
  void changeState({
    required List<Widget> newSearchList,
  }) {
    searchList = newSearchList;
    notifyListeners();
  }
}