//таблица замены
import 'package:places/ui/screen/res/app_strings.dart';

final replaceTable = <String, String>{
  'other': AppStrings.specialPlaceCategoryText,
  'monument': AppStrings.specialPlaceCategoryText,
  'theatre': AppStrings.specialPlaceCategoryText,
  'museum': AppStrings.museumCategoryText,
  'park': AppStrings.parkCategoryText,
  'hotel': AppStrings.hotelCategoryText,
  'restaurant': AppStrings.restaurantCategoryText,
  'temple': AppStrings.specialPlaceCategoryText,
  'cafe': AppStrings.cafeCategoryText,
};

class Place {
  late final String id;
  late final double lat;
  late final double lon;
  late final String name;
  late final List<String> urls;
  late final String placeType;
  late final String description;
  late String beatifulType;
  late bool wished;
  late bool seen;

  Place({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
    this.beatifulType = AppStrings.specialPlaceCategoryText,
    this.wished = false,
    this.seen = false,
  });

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    lat = double.parse(json['lat'].toString());
    lon = double.parse(json['lng'].toString());
    name = json['name'].toString();
    if (json['urls'] != null) {
      final t = json['urls'] as List;
      final arr = <String>[];
      for (final e in t) {
        arr.add(e.toString());
      }
      urls = arr;
    } else {
      urls = [
        'https://aa.aa.ru/1.jpg',
      ];
    }

    placeType = json['placeType'].toString();
    beatifulType = replaceTable[placeType]!;
    description = json['description'].toString();
    wished = false;
    seen = false;
  }

  @override
  String toString() {
    return '$name $lat $lon';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'lat': lat,
      'lon': lon,
      'name': name,
      'urls': urls,
      'placeType': placeType,
      'description': description,
    };
  }

  @override
  bool operator ==(Object other) =>
      other is Place &&
      lat == other.lat &&
      lon == other.lon &&
      name == other.name &&
      urls == other.urls &&
      placeType == other.placeType &&
      description == other.description;
}
