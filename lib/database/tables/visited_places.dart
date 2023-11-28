import 'package:moor_flutter/moor_flutter.dart';

class VisitedPlaces extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}