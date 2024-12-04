import 'dart:math';
import 'dart:ui';
import 'dart:math' as math;

import 'package:doddle/domain/models/point.dart';
import 'package:doddle/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/application/providers/canvas/canvas_provider.dart';

abstract class PenEffect {
  DrawController get drawController => globalRef.read(canvasNotifierProvider);


  // void initialize(Ref ref) {
  //   drawController = ref.read(canvasNotifierProvider);
  // }
  
  void paint(Canvas canvas, Path path, Paint paint);
  
  // New method to handle point additions
  void onPointAdd(Point point){}
  void onPointEnd(){}
  
  List<Offset> getSymmetricalPositions(Offset point) {
    final relX = point.dx;
    final relY = point.dy;
    final dist = math.sqrt(relX * relX + relY * relY);
    final angle = math.atan2(relX, relY);

    List<Offset> result = [];
    for (int i = 0; i < drawController.symmetryLines!; i++) {
      final theta = angle + 2 * pi * i / drawController.symmetryLines!;
      final x = math.sin(theta) * dist;
      final y = math.cos(theta) * dist;
      result.add(Offset(x, y));

      if (drawController.mirrorSymmetry) {
        result.add(Offset(-x, y));
      }
    }
    return result;
  }

  Color getRandomColor() {
    final random = math.Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
