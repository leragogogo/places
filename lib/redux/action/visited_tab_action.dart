// Базовое действие экрана любимых мест.
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

abstract class VisitedTabAction {}

class InitVisitedTabAction extends VisitedTabAction {
  BuildContext context;
  InitVisitedTabAction(this.context);
}

class RemoveVisitedPlaceAction extends VisitedTabAction {
  Place placeForRemoval;
  BuildContext context;
  RemoveVisitedPlaceAction(this.placeForRemoval, this.context);
}

class DragVisitedPlaceAction extends VisitedTabAction {
  int oldIndex;
  int newIndex;
  DragVisitedPlaceAction(this.newIndex, this.oldIndex);
}
