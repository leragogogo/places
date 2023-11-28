import 'package:equatable/equatable.dart';

/// Модель точки на карте
class MapPoint extends Equatable {
  MapPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.isClicked,
  });

  final String name;

  final double latitude;

  final double longitude;

  bool isClicked;

  @override
  List<Object?> get props => [name, latitude, longitude];
}
