import 'dart:ui';
import 'dart:math' as math;
import 'package:doddle/domain/models/point.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';

class ChalkDot {
  final Offset position;
  final double opacity;
  final double size;
  final double angle;
  final Color color;

  ChalkDot({
    required this.position,
    required this.opacity,
    required this.size,
    required this.angle,
    required this.color,
  });
}

class CustomPenEffect extends PenEffect {
  final random = math.Random();
  List<ChalkDot> chalkDots = [];

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    for (var dot in chalkDots) {
      final symmetricalDots = getSymmetricalPositions(dot.position);

      for (var position in symmetricalDots) {
        canvas.save();
        canvas.translate(position.dx, position.dy);
        canvas.rotate(dot.angle);

        canvas.drawCircle(
            Offset.zero,
            dot.size * (drawController.penSize ?? 2.0),
            paint
              ..color = dot.color
              ..style = PaintingStyle.fill);

        canvas.restore();
      }
    }
  }

  @override
  void onPointAdd(Point point) {
    if (point.offset == null) return;

    final numDots = 12; // Higher density for more chalk-like appearance
    for (int i = 0; i < numDots; i++) {
      final spread = 8.0; // Wider spread for chalk texture
      final randomOffset = Offset(random.nextDouble() * spread - spread / 2,
          random.nextDouble() * spread - spread / 2);

      addChalkDots([
        ChalkDot(
          position: point.offset! + randomOffset,
          opacity: random.nextDouble() * 0.3 +
              0.3, // Random opacity between 0.3 and 0.6
          size: random.nextDouble() * 0.6 +
              0.6, // Random size between 0.6 and 1.2
          angle: random.nextDouble() * math.pi * 2, // Full rotation possible,
          color: drawController.isRandomColor
              ? getRandomColor()
              : drawController.currentColor,
        ),
      ]);
    }
  }

  @override
  void onPointEnd() {
    chalkDots = [];
  }

  void addChalkDots(List<ChalkDot> dots) {
    chalkDots = [...chalkDots, ...dots];
  }
}
