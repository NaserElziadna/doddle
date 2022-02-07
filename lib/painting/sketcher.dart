import 'package:doddle/generated/assets.gen.dart';
import 'package:doddle/models/draw_controller.dart';
import 'package:doddle/models/point.dart';
import 'package:flutter/material.dart';

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
    print(size.toString());
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    var angle = 360 / (symmetryLines);

    print(angle);
    Path path = Path();
    for (var j = 0; j < points.length - 1; j++) {
      if (points[j + 1] != null) {
        if (points[j]!.offset != null && points[j + 1]!.offset != null) {
          if (penTool == PenTool.normalPen || penTool == PenTool.glowPen) {
            path.moveTo(points[j]!.offset!.dx, points[j]!.offset!.dy);
            path.lineTo(points[j + 1]!.offset!.dx, points[j + 1]!.offset!.dy);

            // Shapes aa = Shapes(
            //     canvas: canvas, center: points[j]!.offset!, paint: paint);
            // aa.drawType(ShapeType.Star5);

          }

          // Shapes shapes = Shapes(
          //     canvas: canvas,
          //     radius: 10,
          //     paint: Paint()
          //       ..color = color
          //       ..style = PaintingStyle.stroke
          //       ..strokeWidth = 3.0,
          //     center: points[j]!.offset!,
          //     angle: 0);

          // shapes.drawType(ShapeType.Triangle); // enum
        }
      } else {
        j++;
      }
    }

    print(color);

    for (var i = 0; i <= symmetryLines; i++) {
      if (penTool == PenTool.glowPen) {
        canvas.drawPath(
            path,
            Paint()
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0)
              ..color = color
              ..style = PaintingStyle.stroke
              // ..shader = sweepShader
              ..strokeWidth = 10.0);

        canvas.drawPath(path, paint);
      } else if (penTool == PenTool.normalPen) {
        canvas.drawPath(
            path,
            Paint()
              ..color = color
              ..strokeJoin = StrokeJoin.round
              ..style = PaintingStyle.stroke
              // ..shader = sweepShader
              ..strokeWidth = 5.0);
      }
      canvas.rotate(angle);
    }
  }
}

//  const SweepGradient colorWheelGradient =
//             SweepGradient(center: Alignment.bottomRight, colors: [
//           Color.fromARGB(255, 255, 0, 0),
//           Color.fromARGB(255, 255, 255, 0),
//           Color.fromARGB(255, 0, 255, 0),
//           Color.fromARGB(255, 0, 255, 255),
//           Color.fromARGB(255, 0, 0, 255),
//           Color.fromARGB(255, 255, 0, 255),
//           Color.fromARGB(255, 255, 0, 0),
//         ]);
//         // If we create a shader from the above SweepGraident, we get
//         // a crash on web, but only on web.
//         final Shader sweepShader =
//             colorWheelGradient.createShader(const Rect.fromLTWH(0, 0, 20, 10));