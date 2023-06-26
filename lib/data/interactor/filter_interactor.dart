import 'package:flutter/material.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/repository/filter_repository.dart';

class FilterInteractor extends ChangeNotifier {
  
  static FilterInteractor? _instance;
  final FilterRepository filterRepository = FilterRepository();
  late RangeValues activeCurRadius;

  late List<FilterItem> activeFilterItems;
  late RangeValues candidateCurRadius;

  late List<FilterItem> candidateFilterItems;

  // <Singleton>
  factory FilterInteractor() => _instance ?? FilterInteractor._internal();

  FilterInteractor._internal() {
    _instance = this;
    activeFilterItems = filterRepository.activeFilterItems;
    activeCurRadius = filterRepository.activeRadius;
    candidateFilterItems = filterRepository.candidateFilterItems;
    candidateCurRadius = filterRepository.candidateRadius;
  }

  void changeStateOfCategory(int index) {
    candidateFilterItems[index].isSelected = !candidateFilterItems[index].isSelected;
  }

  void candidateToActive(){
    for (var i = 0; i < candidateFilterItems.length;i++){
      activeFilterItems[i].isSelected = candidateFilterItems[i].isSelected;
    }

    activeCurRadius = RangeValues(candidateCurRadius.start, candidateCurRadius.end);
  }

  void activeToCandidate(){
    for (var i = 0; i < candidateFilterItems.length;i++){
      candidateFilterItems[i].isSelected = activeFilterItems[i].isSelected;
    }

    candidateCurRadius = RangeValues(activeCurRadius.start, activeCurRadius.end);
  }

  List<FilterItem> getSelectedActiveCategories() {
    final selectedCategories = <FilterItem>[];
    for (final item in activeFilterItems) {
      if (item.isSelected) {
        selectedCategories.add(item);
      }
    }

    return selectedCategories;
  }

  List<FilterItem> getSelectedCandidateCategories() {
    final selectedCategories = <FilterItem>[];
    for (final item in candidateFilterItems) {
      if (item.isSelected) {
        selectedCategories.add(item);
      }
    }

    return selectedCategories;
  }

  bool isAtLeastOneCategorySelected() {
    var count = 0;
    for (final filterItem in candidateFilterItems) {
      if (filterItem.isSelected) {
        count += 1;
      }
    }

    return count > 0;
  }

  void clearActiveCategories() {
    for (final element in candidateFilterItems) {
      element.isSelected = false;
    }
  }
}
