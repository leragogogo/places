import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier{
  List<Widget> history = [];
  void changeState({
    required List<Widget> newHistory,
  }) {
    history = newHistory;

    notifyListeners();
  }
}