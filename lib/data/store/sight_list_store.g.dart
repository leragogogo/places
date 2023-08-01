// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SightListStore on SightListStoreBase, Store {
  late final _$filteredPlacesAtom =
      Atom(name: 'SightListStoreBase.filteredPlaces', context: context);

  @override
  List<Place> get filteredPlaces {
    _$filteredPlacesAtom.reportRead();
    return super.filteredPlaces;
  }

  @override
  set filteredPlaces(List<Place> value) {
    _$filteredPlacesAtom.reportWrite(value, super.filteredPlaces, () {
      super.filteredPlaces = value;
    });
  }

  late final _$isRequestDoneWithErrorAtom =
      Atom(name: 'SightListStoreBase.isRequestDoneWithError', context: context);

  @override
  bool get isRequestDoneWithError {
    _$isRequestDoneWithErrorAtom.reportRead();
    return super.isRequestDoneWithError;
  }

  @override
  set isRequestDoneWithError(bool value) {
    _$isRequestDoneWithErrorAtom
        .reportWrite(value, super.isRequestDoneWithError, () {
      super.isRequestDoneWithError = value;
    });
  }

  late final _$initPlacesAsyncAction =
      AsyncAction('SightListStoreBase.initPlaces', context: context);

  @override
  Future<void> initPlaces() {
    return _$initPlacesAsyncAction.run(() => super.initPlaces());
  }

  late final _$SightListStoreBaseActionController =
      ActionController(name: 'SightListStoreBase', context: context);

  @override
  void filterPlaces(
      {required RangeValues radius, required List<FilterItem> categories}) {
    final _$actionInfo = _$SightListStoreBaseActionController.startAction(
        name: 'SightListStoreBase.filterPlaces');
    try {
      return super.filterPlaces(radius: radius, categories: categories);
    } finally {
      _$SightListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToFavorites({required Place place}) {
    final _$actionInfo = _$SightListStoreBaseActionController.startAction(
        name: 'SightListStoreBase.addToFavorites');
    try {
      return super.addToFavorites(place: place);
    } finally {
      _$SightListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromFavorites({required Place place}) {
    final _$actionInfo = _$SightListStoreBaseActionController.startAction(
        name: 'SightListStoreBase.removeFromFavorites');
    try {
      return super.removeFromFavorites(place: place);
    } finally {
      _$SightListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filteredPlaces: ${filteredPlaces},
isRequestDoneWithError: ${isRequestDoneWithError}
    ''';
  }
}
