import 'dart:ui';

import 'package:doddle/domain/models/effects/pen_effect.dart';

class EraserEffect extends PenEffect {
  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    paint.blendMode = BlendMode.clear;
    canvas.drawPath(path, paint);
  }
}
