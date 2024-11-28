import 'package:doddle/domain/models/point.dart';
import 'package:doddle/domain/models/stamp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'draw_controller.freezed.dart';

enum PenTool {
  normalPen,
  normalWithShaderPen,
  glowPen,
  glowWithDotsPen,
  sprayPen,
  eraserPen,
  customPen
}

@freezed
class DrawController with _$DrawController {
  const factory DrawController({
    @Default(true) bool isPanActive,
    @Default([]) List<Point?>? points,
    @Default([]) List<Stamp?>? stamp,
    @Default([]) List<Stamp?>? stampUndo,
    @Default(Color(0x12457895)) Color currentColor,
    @Default(false) bool isRandomColor,
    GlobalKey? globalKey,
    @Default(20) double? symmetryLines,
    @Default(PenTool.glowPen) PenTool? penTool,
    @Default(2) double? penSize,
    @Default(false) bool mirrorSymmetry,
    @Default(true) bool showGuidelines,
    @Default(Color(0x12457895)) Color canvasBackgroundColor,
  }) = _DrawController;
}
