import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/application/providers/canvas/canvas_provider.dart';

abstract class PenEffect {
  late final DrawController drawController;
  
  void initialize(WidgetRef ref) {
    drawController = ref.read(canvasProvider);
  }
  
  void paint(Canvas canvas, Path path, Paint paint);
  
  // Utility methods for all effects
  List<Offset> getSymmetryPoints(Offset point, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final relativePoint = point - center;
    final symmetryLines = drawController.symmetryLines ?? 1;
    
    List<Offset> points = [];
    for (var i = 0; i < symmetryLines; i++) {
      final angle = 2 * math.pi * i / symmetryLines;
      final rotatedPoint = _rotatePoint(relativePoint, angle);
      points.add(rotatedPoint + center);
      
      if (drawController.mirrorSymmetry) {
        points.add(Offset(-rotatedPoint.dx, rotatedPoint.dy) + center);
      }
    }
    return points;
  }

  Offset _rotatePoint(Offset point, double angle) {
    final cos = math.cos(angle);
    final sin = math.sin(angle);
    return Offset(
      point.dx * cos - point.dy * sin,
      point.dx * sin + point.dy * cos,
    );
  }
}
