import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/database/tables/favourite_places.dart';
import 'package:places/database/tables/history.dart';
import 'package:places/database/tables/visited_places.dart';

part 'database.g.dart';

@UseMoor(tables: [Historys, FavouritePlaces, VisitedPlaces])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnections());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onUpgrade: (migrator, from, to) async {
        if (from == 1) {
          await migrator.renameTable(favouritePlaces, 'favoutite_places');
        }
      });

  Future<List<History>> get allHistory => select(historys).get();

  Future<List<FavouritePlace>> get allFavouritePlaces =>
      select(favouritePlaces).get();

  Future<List<VisitedPlace>> get allVisitedPlaces =>
      select(visitedPlaces).get();

  Future<int> addHistory(HistorysCompanion history) {
    return into(historys).insert(history);
  }

  Future<int> addFavouritePlace(FavouritePlacesCompanion favoutitePlace) {
    return into(favouritePlaces).insert(favoutitePlace);
  }

  Future<int> addVisitedPlace(VisitedPlacesCompanion visitedPlace) {
    return into(visitedPlaces).insert(visitedPlace);
  }

  Future<void> removeHistory(int id) {
    return customStatement('DELETE FROM historys WHERE id = $id');
  }

  Future<void> removeAllHistory() {
    return customStatement('DELETE FROM historys');
  }

  Future<void> removeFavouritePlace(String title) {
    return customStatement('DELETE FROM favourite_places WHERE title = $title');
  }

  Future<void> removeVisitedPlace(int id) {
    return customStatement('DELETE FROM visitedPlaces WHERE id = $id');
  }
}

LazyDatabase _openConnections() {
  return LazyDatabase(() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final file = join(dbPath.path, 'places.sql');
    return FlutterQueryExecutor(path: file);
  });
}
