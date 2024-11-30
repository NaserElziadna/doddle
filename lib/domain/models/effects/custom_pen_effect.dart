import 'dart:ui';
import 'dart:math' as math;

import 'package:doddle/domain/models/effects/pen_effect.dart';

class CustomPenEffect extends PenEffect {
  final _random = math.Random();
  
  // Map to store effect data for each point
  Map<int, List<_PointEffect>> _pointEffects = {};

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    // Extract points from path by computing path metrics
    final metrics = path.computeMetrics();
    for (var metric in metrics) {
      final length = metric.length;
      final numPoints = (length / 5).ceil(); // Sample points every 5 pixels
      
      for (var i = 0; i < numPoints; i++) {
        final distance = (i * length) / (numPoints - 1);
        final pos = metric.getTangentForOffset(distance)?.position;
        
        if (pos != null) {
            _pointEffects[i] = List.generate(3, (_) => _PointEffect(
              jitter: Offset(
                _random.nextDouble() * 10 - 5,
                _random.nextDouble() * 10 - 5
              ),
              opacity: 0.3,
              strokeWidth: drawController.penSize! * 0.5
            ));
          
          // Draw dots using stored effects
          for (var effect in _pointEffects[i]!) {
            canvas.drawCircle(
              pos.translate(effect.jitter.dx, effect.jitter.dy),
              effect.strokeWidth,
              Paint()
                ..color = drawController.currentColor.withOpacity(effect.opacity)
                ..style = PaintingStyle.fill
            );
          }
        }
      }
    }

    // Draw original path with reduced opacity
    canvas.drawPath(
      path,
      Paint()
        ..color = drawController.currentColor.withOpacity(0.5)
        ..strokeWidth = drawController.penSize! * 0.8
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
    );
  }
}

// Class to store effect data for each point
class _PointEffect {
  final Offset jitter;
  final double opacity;
  final double strokeWidth;

  _PointEffect({
    required this.jitter,
    required this.opacity, 
    required this.strokeWidth
  });
}