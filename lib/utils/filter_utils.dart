import 'dart:math';
import 'package:flutter/material.dart';
import 'package:places/domain/location.dart';

class FilterUtils {
  static double calcDistance(Location point1, Location point2) {
    const ky = 40000 / 360;
    final kx = cos(pi * point1.lat / 180.0) * ky;
    final dx = (point1.lon - point2.lon).abs() * kx;
    final dy = (point1.lat - point2.lat).abs() * ky;

    return sqrt(dx * dx + dy * dy);
  }

  static bool isPointInArea({
    required Location point,
    required Location center,
    required RangeValues radius,
    required bool stateOfCategory,
  }) {
    final distance = calcDistance(center, point);

    return distance >= radius.start &&
        distance <= radius.end &&
        stateOfCategory;
  }
}
