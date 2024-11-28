import 'dart:ui';

import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'dart:math' as math;

class SprayEffect extends PenEffect {
  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    final random = math.Random();

    for (var j = 0; j < drawController.points!.length - 1; j++) {
      if (drawController.points![j + 1] == null) {
        j++;
        continue;
      }

      final currentPoint = drawController.points![j]?.offset;
      final nextPoint = drawController.points![j + 1]?.offset;

      if (currentPoint != null && nextPoint != null) {
        // If points are the same (holding still), create multiple spray iterations
        final isHolding = currentPoint == nextPoint;
        final iterations =
            isHolding ? 3 : 1; // Increase spray density when holding still

        for (var iter = 0; iter < iterations; iter++) {
          // Create random spray points around the current position
          final sprayDensity = (drawController.penSize! * 2).round();

          for (var i = 0; i < sprayDensity; i++) {
            final sprayRadius = drawController.penSize! * 2;
            final randomRadius = random.nextDouble() * sprayRadius;
            final randomAngle = random.nextDouble() * 2 * math.pi;

            final sprayX =
                currentPoint.dx + randomRadius * math.cos(randomAngle);
            final sprayY =
                currentPoint.dy + randomRadius * math.sin(randomAngle);

            canvas.drawCircle(
              Offset(sprayX, sprayY),
              0.5,
              Paint()
                ..color = drawController.currentColor.withOpacity(0.3)
                ..style = PaintingStyle.fill,
            );
          }
        }
      }
    }
  }
}
