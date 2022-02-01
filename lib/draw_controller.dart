import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'point.dart';

class DrawController {
  final List<Point?>? points;
  final List<Stamp?>? stamp;
  final Color currentColor;
  final GlobalKey? globalKey;
  final double? symmetryLines;

  const DrawController({
    this.points = const [],
    this.stamp =const [],
    this.currentColor = const Color(0x12457895) ,
    this.globalKey,
    this.symmetryLines = 20,
  });

  DrawController copyWith({
    List<Point?>? points,
    List<Stamp?>? stamp,
    Color? currentColor,
    GlobalKey? globalKey,
    double? symmetryLines,
  }) {
    return DrawController(
      points: points ?? this.points,
      stamp: stamp ?? this.stamp,
      currentColor: currentColor ?? this.currentColor,
      globalKey: globalKey ?? this.globalKey,
      symmetryLines: symmetryLines ?? this.symmetryLines,
    );
  }

  @override
  String toString() {
    return 'DrawController(points: ${points.toString()}, stamp: $stamp, currentColor: $currentColor, globalKey: $globalKey, symmetryLines: $symmetryLines)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DrawController &&
      listEquals(other.points, points) &&
      listEquals(other.stamp, stamp) &&
      other.currentColor == currentColor &&
      other.globalKey == globalKey &&
      other.symmetryLines == symmetryLines;
  }

  @override
  int get hashCode {
    return points.hashCode ^
      stamp.hashCode ^
      currentColor.hashCode ^
      globalKey.hashCode ^
      symmetryLines.hashCode;
  }
}

class Stamp {
  ui.Image image;
  Stamp({
    required this.image,
  });

  Stamp copyWith({
    ui.Image? image,
  }) {
    return Stamp(
      image: image ?? this.image,
    );
  }

  @override
  String toString() => 'Stamp(image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stamp && other.image == image;
  }

  @override
  int get hashCode => image.hashCode;
}
