import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/point.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';


import 'shapes.dart';

class Sketcher extends CustomPainter {
  final List<Point?> points;
  final Size screenSize;
  final double symmetryLines;
  final Color color;
  final PenTool penTool;
  List<Offset> randomOffsets = [];
  final double penSize;

  Sketcher(
    this.points,
    this.screenSize,
    this.symmetryLines,
    this.color,
    this.penTool,
    this.penSize,
  );

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = penSize;

    Path path = Path();
    _drawPoints(canvas, path, paint);
    _applyPenEffects(canvas, path, paint);
  }

  void _drawPoints(Canvas canvas, Path path, Paint paint) {
    for (var j = 0; j < points.length - 1; j++) {
      if (points[j + 1] == null) {
        j++;
        continue;
      }

      final currentPoint = points[j]?.offset;
      final nextPoint = points[j + 1]?.offset;
      
      if (currentPoint != null && nextPoint != null) {
        if (penTool == PenTool.customPen) {
          for (var offset in points[j]!.randomOffset!) {
            canvas.drawRect(offset & const Size(1.0, 1.0), paint);
          }
        } else {
          path.moveTo(currentPoint.dx, currentPoint.dy);
          path.lineTo(nextPoint.dx, nextPoint.dy);
        }
      }
    }
  }

  void _applyPenEffects(Canvas canvas, Path path, Paint paint) {
    if (penTool == PenTool.eraserPen) {
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.black
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = penSize,
      );
      return;
    }

    for (var i = 0; i < symmetryLines; i++) {
      _drawPathWithEffect(canvas, path, paint);
      performSymmetryLines(canvas, screenSize, symmetryLines);
    }
  }

  void _drawPathWithEffect(Canvas canvas, Path path, Paint paint) {
    switch (penTool) {
      case PenTool.glowPen:
        _drawGlowPath(canvas, path, paint);
        break;
      case PenTool.normalPen:
        _drawNormalPath(canvas, path);
        break;
      case PenTool.normalWithShaderPen:
        _drawShaderPath(canvas, path);
        break;
      case PenTool.glowWithDotsPen:
        _drawGlowDotsPath(canvas, path, paint);
        break;
      default:
        break;
    }
  }

  void _drawGlowPath(Canvas canvas, Path path, Paint paint) {
    // Outer glow
    canvas.drawPath(
      path,
      paint
        ..color = color.withOpacity(0.2)
        ..strokeWidth = penSize * 3
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // Middle glow
    canvas.drawPath(
      path,
      paint
        ..color = color.withOpacity(0.4)
        ..strokeWidth = penSize * 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    // Core line
    canvas.drawPath(
      path,
      paint
        ..color = color
        ..strokeWidth = penSize
        ..maskFilter = null,
    );
  }

  void _drawNormalPath(Canvas canvas, Path path) {
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = penSize,
    );
  }

  void _drawShaderPath(Canvas canvas, Path path) {
    canvas.drawPath(
      path,
      Paint()
        ..shader = sweepShader
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = penSize,
    );
  }

  void _drawGlowDotsPath(Canvas canvas, Path path, Paint paint) {
    // Draw the base glow path
    _drawGlowPath(canvas, path, paint);

    // Add dots along the path
    for (var i = 0.0; i <= 1.0; i += 0.1) {
      final metric = path.computeMetrics().first;
      final tangent = metric.getTangentForOffset(metric.length * i);
      
      if (tangent != null) {
        final position = tangent.position;
        canvas.drawCircle(
          position,
          penSize / 4,
          Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
      }
    }
  }
}

performSymmetryLines(Canvas canvas, Size size, double symmetryLines) {
  if (symmetryLines == 2) {
    canvas.translate(size.width / 2, 0);
  } else if (symmetryLines == 3) {
    canvas.rotate(180 / 12.2);
  } else if (symmetryLines == 4) {
    canvas.rotate(360 / 4.5);
  } else if (symmetryLines == 8) {
    canvas.rotate(360 / 4.5);
  } else if (symmetryLines == 5) {
    canvas.rotate(180 / 5.5);
  } else if (symmetryLines == 10) {
    canvas.rotate(180 / 5.5);
  } else if (symmetryLines == 6) {
    canvas.rotate(360 / 8);
  }
  // else if (symmetryLines == 12) {
  //   canvas.rotate(360 / 8);
  // }else if (symmetryLines == 8) {
  //   canvas.rotate(360/180);
  // }
  else {
    canvas.rotate(360 / symmetryLines);
  }
}

// double getAngle(double symmetryLines) {
//   if (symmetryLines == 1) {
//     return 360 / (symmetryLines);
//   } else if (symmetryLines == 2) {
//     return 360;
//   }
//   return 360 / (symmetryLines);
// }

const SweepGradient colorWheelGradient =
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
final Shader sweepShader =
    colorWheelGradient.createShader(const Rect.fromLTWH(0, 0, 100, 10));
