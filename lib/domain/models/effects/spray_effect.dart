import 'dart:ui';
import 'package:doddle/domain/models/point.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'dart:math' as math;

class SprayDot {
  final Offset position;
  final double opacity;
  final double size;
  final Color color;

  SprayDot({
    required this.position,
    required this.opacity,
    required this.size,
    required this.color,
  });
}

class SprayEffect extends PenEffect {
  final random = math.Random();
  List<SprayDot> sprayDots = [];

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    for (var dot in sprayDots) {
      // Get all symmetrical positions for this dot
      final symmetricalDots = getSymmetricalPositions(dot.position);
      
      // Draw a dot at each symmetrical position
      for (var position in symmetricalDots) {
        canvas.drawCircle(
          position,
          dot.size * (drawController.penSize ?? 2.0),
          paint
            ..color = dot.color.withOpacity(dot.opacity)
        );
      }
    }
  }

  @override
  void onPointAdd(Point point) {
    if (point.offset == null) return;
    
    // Create multiple spray dots around the point
    final numDots = 10; // Adjust this for more/less density
    for (int i = 0; i < numDots; i++) {
      final spread = 10.0; // Adjust this for wider/narrower spray
      final randomOffset = Offset(
        random.nextDouble() * spread - spread/2,
        random.nextDouble() * spread - spread/2
      );
      
      addSprayDots([
        SprayDot(
          position: point.offset! + randomOffset,
          opacity: random.nextDouble() * 0.3 + 0.1, // Random opacity between 0.1 and 0.4
          size: random.nextDouble() * 0.5 + 0.5, // Random size between 0.5 and 1.0
          color: drawController.isRandomColor ? getRandomColor() : drawController.currentColor,
        ),
      ]);
    }
  }

  @override
  void onPointEnd() {
    sprayDots = [];
  }

  void addSprayDots(List<SprayDot> dots) {
    sprayDots = [...sprayDots, ...dots];
  }
}
