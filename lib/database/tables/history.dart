import 'package:moor_flutter/moor_flutter.dart';

class Historys extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}