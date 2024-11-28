import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class GlowWithDotsEffect extends PenEffect {
  @override
  void paint(Canvas canvas, Path path, Paint paint) {

    final pathWithDots = dashPath(  
          path,
          dashArray: CircularIntervalList<double>(<double>[5, 10]), // Changed to create 5px dashes with 10px gaps
        );

    canvas.drawPath(
        pathWithDots,
        Paint()
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0)
          ..color = drawController.currentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0);

    canvas.drawPath(
        pathWithDots,
        paint..strokeWidth = drawController.penSize!);
  }
}
