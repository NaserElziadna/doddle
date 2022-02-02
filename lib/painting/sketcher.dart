import 'package:doddle/models/point.dart';
import 'package:flutter/material.dart';



class Sketcher extends CustomPainter {
  final List<Point?> points;
  final Size screenSize;
  final double symmetryLines;
  final Color color;

  Sketcher(this.points, this.screenSize, this.symmetryLines, this.color);

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
          path.moveTo(points[j]!.offset!.dx, points[j]!.offset!.dy);
          path.lineTo(points[j + 1]!.offset!.dx, points[j + 1]!.offset!.dy);
        }
      } else {
        j++;
      }
    }

    print(color);
    for (var i = 0; i <= symmetryLines; i++) {
      canvas.drawPath(
          path,
          Paint()
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0)
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10.0);

      canvas.drawPath(path, paint);
      canvas.rotate(angle);
    }
  }
}
