
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:flutter/material.dart';

class GlowEffect extends PenEffect {
  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    canvas.drawPath(
      path,
      Paint()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0)
        ..color = drawController.currentColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = drawController.penSize! + 5,
    );

    canvas.drawPath(path, paint..color = Colors.white);
  }
}
