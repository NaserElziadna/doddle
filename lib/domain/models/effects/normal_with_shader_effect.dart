import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:flutter/material.dart';

class NormalWithShaderEffect extends PenEffect {
  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    canvas.drawPath(
      path,
      Paint()
        ..shader = sweepShader
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = drawController.penSize!,
    );
  }

  static final SweepGradient colorWheelGradient =
      SweepGradient(center: Alignment.bottomRight, colors: [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 0),
  ]);
// If we create a shader from the above SweepGraident, we get
// a crash on web, but only on web.
  static final Shader sweepShader =
      colorWheelGradient.createShader(const Rect.fromLTWH(0, 0, 100, 10));
}
