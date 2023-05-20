import 'package:places/domain/categories.dart';

class Sight {
  final String name;
  final double lat;
  final double lon;
  final List<String> images;
  final String details;
  final Categories type;

  Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.images,
    required this.details,
    required this.type,
  });
}
