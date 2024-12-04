import 'dart:ui';

import 'package:doddle/domain/models/effects/pen_effect.dart';

class NormalEffect extends PenEffect {
  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    canvas.drawPath(path, paint..color = drawController.currentColor);
  }
}
