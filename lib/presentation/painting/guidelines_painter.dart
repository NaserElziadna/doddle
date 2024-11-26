import 'package:flutter/material.dart';
import 'dart:math' as math;

class GuidelinesPainter extends CustomPainter {
  final double symmetryLines;
  final double penSize;
  final bool showGuidelines;

  GuidelinesPainter({
    required this.symmetryLines,
    required this.penSize,
    required this.showGuidelines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!showGuidelines) return;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    final guidelinePaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final radius = math.min(size.width, size.height) / 2 - penSize;

    canvas.drawCircle(Offset.zero, radius, guidelinePaint);

    for (int i = 0; i < symmetryLines; i++) {
      final angle = i * 2 * math.pi / symmetryLines;
      final x = math.cos(angle) * radius;
      final y = math.sin(angle) * radius;
      canvas.drawLine(Offset.zero, Offset(x, y), guidelinePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(GuidelinesPainter oldDelegate) {
    return oldDelegate.symmetryLines != symmetryLines ||
        oldDelegate.showGuidelines != showGuidelines;
  }
}
