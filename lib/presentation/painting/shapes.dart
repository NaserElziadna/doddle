import 'dart:math';
import 'dart:ui';

double radians(double degree) {
  return degree * pi / 180;
}

class Shapes {
  Shapes({this.canvas, this.paint, this.radius = 1, this.center = Offset.zero, this.angle = 0}) {
    paint ??= Paint();
  }

  static List<String> types = ShapeType.values.map((ShapeType type) => type.toString().split('.')[1]).toList();

  Canvas? canvas;
  Paint? paint;
  double radius;
  Offset center;
  double angle;

  Rect rect() => Rect.fromCircle(center: Offset.zero, radius: radius);

  void drawCircle() {
    rotate(() {
      canvas!.drawCircle(Offset.zero, radius, paint!);
    });
  }

  void drawRect() {
    rotate(() {
      canvas!.drawRect(rect(), paint!);
    });
  }

  void drawRRect({double? cornerRadius}) {
    rotate(() {
      canvas!.drawRRect(RRect.fromRectAndRadius(rect(), Radius.circular(cornerRadius ?? radius * 0.2)), paint!);
    });
  }

  void drawPolygon(int num, {double initialAngle = 0}) {
    rotate(() {
      final Path path = Path();
      for (int i = 0; i < num; i++) {
        final double radian = radians(initialAngle + 360 / num * i.toDouble());
        final double x = radius * cos(radian);
        final double y = radius * sin(radian);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas!.drawPath(path, paint!);
    });
  }

  void drawHeart() {
    rotate(() {
      final Path path = Path();

      path.moveTo(0, radius);

      path.cubicTo(-radius * 2, -radius * 0.5, -radius * 0.5, -radius * 1.5, 0, -radius * 0.5);
      path.cubicTo(radius * 0.5, -radius * 1.5, radius * 2, -radius * 0.5, 0, radius);

      canvas!.drawPath(path, paint!);
    });
  }

  void drawCustom() {
    rotate(() {
      int a = 20;
      for (var i = 0; i < a; i++) {
        canvas!.drawRect(
            center + Offset(center.dx + Random().nextInt(a) * 1.0, center.dy - Random().nextInt(a) * 1.0) &
                const Size(1.0, 1.0),
            paint!);
      }
    });
  }

  void drawStar(int num, {double initialAngle = 0}) {
    rotate(() {
      final Path path = Path();
      for (int i = 0; i < num; i++) {
        final double radian = radians(initialAngle + 360 / num * i.toDouble());
        final double x = radius * (i.isEven ? 0.5 : 1) * cos(radian);
        final double y = radius * (i.isEven ? 0.5 : 1) * sin(radian);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas!.drawPath(path, paint!);
    });
  }

  void drawType(ShapeType type) {
    switch (type) {
      case ShapeType.circle:
        drawCircle();
        break;
      case ShapeType.rect:
        drawRect();
        break;
      case ShapeType.roundedRect:
        drawRRect();
        break;
      case ShapeType.triangle:
        drawPolygon(3, initialAngle: 30);
        break;
      case ShapeType.diamond:
        drawPolygon(4, initialAngle: 0);
        break;
      case ShapeType.pentagon:
        drawPolygon(5, initialAngle: -18);
        break;
      case ShapeType.hexagon:
        drawPolygon(6, initialAngle: 0);
        break;
      case ShapeType.octagon:
        drawPolygon(8, initialAngle: 0);
        break;
      case ShapeType.decagon:
        drawPolygon(10, initialAngle: 0);
        break;
      case ShapeType.dodecagon:
        drawPolygon(12, initialAngle: 0);
        break;
      case ShapeType.heart:
        drawHeart();
        break;
      case ShapeType.star5:
        drawStar(10, initialAngle: 15);
        break;
      case ShapeType.star6:
        drawStar(12, initialAngle: 0);
        break;
      case ShapeType.star7:
        drawStar(14, initialAngle: 0);
        break;
      case ShapeType.star8:
        drawStar(16, initialAngle: 0);
        break;
      case ShapeType.custom:
        drawCustom();
        break;
    }
  }

  void draw(String typeString) {
    final ShapeType type = ShapeType.values
        .firstWhere((ShapeType t) => t.toString() == 'ShapeType.$typeString', orElse: () => ShapeType.circle);
    drawType(type);
  }

  void rotate(VoidCallback callback) {
    canvas!.save();
    canvas!.translate(center.dx, center.dy);
    canvas!.rotate(angle);
    callback();
    canvas!.restore();
  }
}

enum ShapeType {
  circle,
  rect,
  custom,
  roundedRect,
  triangle,
  diamond,
  pentagon,
  hexagon,
  octagon,
  decagon,
  dodecagon,
  heart,
  star5,
  star6,
  star7,
  star8,
}
