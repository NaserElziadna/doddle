import 'package:doddle/generated/assets.gen.dart';
import 'package:doddle/models/draw_controller.dart';
import 'package:doddle/models/point.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import 'shapes.dart';

class Sketcher extends CustomPainter {
  final List<Point?> points;
  final Size screenSize;
  final double symmetryLines;
  final Color color;
  final PenTool penTool;

  Sketcher(this.points, this.screenSize, this.symmetryLines, this.color,
      this.penTool);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("penTool =  $penTool");
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    var angle = 360 / (symmetryLines);

    Path path = Path();
    for (var j = 0; j < points.length - 1; j++) {
      if (points[j + 1] != null) {
        if (points[j]!.offset != null && points[j + 1]!.offset != null) {
          path.moveTo(points[j]!.offset!.dx, points[j]!.offset!.dy);
          path.lineTo(points[j + 1]!.offset!.dx, points[j + 1]!.offset!.dy);
        }
      } else {
        j++;
      }
    }
    if (penTool == PenTool.glowPen ||
        penTool == PenTool.normalPen ||
        penTool == PenTool.normalWithShaderPen ||
        penTool == PenTool.glowWithDotsPen) {
      for (var i = 0; i <= symmetryLines; i++) {
        if (penTool == PenTool.glowPen) {
          canvas.drawPath(
              path,
              Paint()
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0)
                ..color = color
                ..style = PaintingStyle.stroke
                ..strokeWidth = 10.0);

          canvas.drawPath(path, paint);
        } else if (penTool == PenTool.normalPen) {
          canvas.drawPath(
              path,
              Paint()
                ..color = color
                ..strokeJoin = StrokeJoin.round
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4.0);
        } else if (penTool == PenTool.normalWithShaderPen) {
          canvas.drawPath(
              path,
              Paint()
                ..color = color
                ..strokeJoin = StrokeJoin.round
                ..style = PaintingStyle.stroke
                ..shader = sweepShader
                ..strokeWidth = 4.0);
        } else if (penTool == PenTool.glowWithDotsPen) {
          canvas.drawPath(
              path,
              Paint()
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0)
                ..color = color
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5.0);

          canvas.drawPath(
              dashPath(
                path,
                dashArray:
                    CircularIntervalList<double>(<double>[100.0, 0.0, 50.0]),
              ),
              paint);
        }
        canvas.rotate(angle);
      }
    } else {
      //eraser
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.black
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20.0,
      );
    }
  }
}

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
