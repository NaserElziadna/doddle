import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:doddle/models/point.dart';

enum PenTool {
  normalPen,
  normalWithShaderPen,
  glowPen,
  glowWithDotsPen,
  eraserPen,
  customPen
}

class DrawController {
  final bool isPanActive;
  final List<Point?>? points;
  final List<Stamp?>? stamp;
  final List<Stamp?>? stampUndo;
  final Color currentColor;
  final bool isRandomColor;
  final GlobalKey? globalKey;
  final double? symmetryLines;
  final PenTool? penTool;
  final double? penSize;

  DrawController({
    this.isPanActive = true,
    this.points = const [],
    this.stamp = const [],
    this.stampUndo = const [],
    this.currentColor = const Color(0x12457895),
    this.isRandomColor = false,
    this.globalKey,
    this.symmetryLines = 20,
    this.penTool = PenTool.glowPen,
    this.penSize = 2,
  });

  //Add Initial Constructer // Add Empty Constructer

  DrawController copyWith({
    bool? isPanActive,
    List<Point?>? points,
    List<Stamp?>? stamp,
    List<Stamp?>? stampUndo,
    Color? currentColor,
    bool? isRandomColor,
    GlobalKey? globalKey,
    double? symmetryLines,
    PenTool? penTool,
    double? penSize,
  }) {
    return DrawController(
      isPanActive: isPanActive ?? this.isPanActive,
      points: points ?? this.points,
      stamp: stamp ?? this.stamp,
      stampUndo: stampUndo ?? this.stampUndo,
      currentColor: currentColor ?? this.currentColor,
      isRandomColor: isRandomColor ?? this.isRandomColor,
      globalKey: globalKey ?? this.globalKey,
      symmetryLines: symmetryLines ?? this.symmetryLines,
      penTool: penTool ?? this.penTool,
      penSize : penSize ?? this.penSize
    );
  }

  @override
  String toString() {
    return 'DrawController(isPanActive: $isPanActive, points: $points, stamp: $stamp, stampUndo: $stampUndo, currentColor: $currentColor, isRandomColor: $isRandomColor, globalKey: $globalKey, symmetryLines: $symmetryLines, penTool: $penTool, penSize: $penSize)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DrawController &&
        other.isPanActive == isPanActive &&
        listEquals(other.points, points) &&
        listEquals(other.stamp, stamp) &&
        listEquals(other.stampUndo, stampUndo) &&
        other.currentColor == currentColor &&
        other.isRandomColor == isRandomColor &&
        other.globalKey == globalKey &&
        other.symmetryLines == symmetryLines &&
        other.penTool == penTool &&
        other.penSize == penSize;
  }

  @override
  int get hashCode {
    return isPanActive.hashCode ^
        points.hashCode ^
        stamp.hashCode ^
        stampUndo.hashCode ^
        currentColor.hashCode ^
        isRandomColor.hashCode ^
        globalKey.hashCode ^
        symmetryLines.hashCode ^
        penTool.hashCode ^
        penSize.hashCode;
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
