import 'dart:ui';

import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:doddle/domain/models/point.dart';

class RainbowStroke {
  final Offset position;
  final Color color;
  final double size;

  RainbowStroke({
    required this.position,
    required this.color,
    required this.size,
  });
}

class NormalWithShaderEffect extends PenEffect {
  final List<RainbowStroke> strokes = [];
  int colorIndex = 0;

  static const List<Color> rainbowColors = [
    Color.fromARGB(255, 255, 0, 0), // Red
    Color.fromARGB(255, 255, 127, 0), // Orange
    Color.fromARGB(255, 255, 255, 0), // Yellow
    Color.fromARGB(255, 0, 255, 0), // Green
    Color.fromARGB(255, 0, 0, 255), // Blue
    Color.fromARGB(255, 75, 0, 130), // Indigo
    Color.fromARGB(255, 148, 0, 211), // Violet
  ];

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    for (var stroke in strokes) {
      final positions = getSymmetricalPositions(stroke.position);
      canvas.drawPoints(
          PointMode.lines,
          positions,
          Paint()
            ..color = stroke.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = stroke.size
            ..strokeCap = StrokeCap.round);
    }
  }

  @override
  void onPointAdd(Point point) {
    if (point.offset == null) return;

    strokes.add(RainbowStroke(
      position: point.offset!,
      color: rainbowColors[colorIndex],
      size: drawController.penSize ?? 2.0,
    ));

    colorIndex = (colorIndex + 1) % rainbowColors.length;
  }

  @override
  void onPointEnd() {
    colorIndex = 0;
    strokes.clear();
  }
}
