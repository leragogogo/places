// ignore_for_file: avoid_print

import 'dart:math';

import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';

class FilterUtils {
  static double calcDistance(Location point1, Location point2) {
    const ky = 40000 / 360;
    final kx = cos(pi * point1.lat / 180.0) * ky;
    final dx = (point1.lon - point2.lon).abs() * kx;
    final dy = (point1.lat - point2.lat).abs() * ky;

    return sqrt(dx * dx + dy * dy);
  }

  // ignore: long-parameter-list
  static bool isPointInArea(
    Location point,
    Location center,
    double minRadius,
    double maxRadius,
    Map<Categories, bool> statesOfCategories,
    Categories category,
  ) {
    var isCategoriesUnused = true;
    for (final key in statesOfCategories.keys) {
      if (statesOfCategories[key] == true) {
        isCategoriesUnused = false;
        break;
      }
    }

    final distance = calcDistance(center, point);

    return isCategoriesUnused
        ? distance >= minRadius && distance <= maxRadius
        : distance >= minRadius &&
            distance <= maxRadius &&
            statesOfCategories[category]!;
  }
}
