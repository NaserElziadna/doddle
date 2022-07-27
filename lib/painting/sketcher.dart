import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';

import 'package:doddle/generated/assets.gen.dart';
import 'package:doddle/models/draw_controller.dart';
import 'package:doddle/models/point.dart';

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
    print("penTool =  $penTool");
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = penSize;

    // var angle = 360 / symmetryLines;
    // print("angle = $angle");
    Path path = Path();
    for (var j = 0; j < points.length - 1; j++) {
      if (points[j + 1] != null) {
        if (points[j]!.offset != null && points[j + 1]!.offset != null) {
          if (penTool == PenTool.customPen) {
            // int a = 20;
            // randomOffsets.add(Offset(
            //     points[j]!.offset!.dx + Random().nextInt(a) * 1.0,
            //     points[j]!.offset!.dy - Random().nextInt(a) * 1.0));
            for (var i = 0; i < points[j]!.randomOffset!.length; i++) {
              canvas.drawRect(
                  points[j]!.randomOffset![i] & const Size(1.0, 1.0), paint);
            }

            // Shapes shapes = Shapes(
            //     canvas: canvas,
            //     radius: 1,
            //     paint: Paint()
            //       ..color = color
            //       ..style = PaintingStyle.stroke
            //       ..strokeWidth = 1.0,
            //     center: points[j]!.offset!,
            //     angle: 0);

            // shapes.drawType(ShapeType.Custom);
          } else {
            randomOffsets = [];
            path.moveTo(points[j]!.offset!.dx, points[j]!.offset!.dy);
            path.lineTo(points[j + 1]!.offset!.dx, points[j + 1]!.offset!.dy);
          }
        }
      } else {
        j++;
      }
    }
    if (penTool == PenTool.glowPen ||
        penTool == PenTool.normalPen ||
        penTool == PenTool.normalWithShaderPen ||
        // penTool == PenTool.customPen ||
        penTool == PenTool.glowWithDotsPen) {
      for (var i = 0; i < symmetryLines; i++) {
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
                ..strokeWidth = penSize);
        } else if (penTool == PenTool.normalWithShaderPen) {
          canvas.drawPath(
              path,
              Paint()
                ..color = color
                ..strokeJoin = StrokeJoin.round
                ..style = PaintingStyle.stroke
                ..shader = sweepShader
                ..strokeWidth = penSize);
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
              paint..strokeWidth =penSize);
        }
        print("symmetryLines = $symmetryLines");
        performSymmetryLines(canvas, size, symmetryLines);
      }
    } else {
      //eraser
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.black
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = penSize,
      );
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
