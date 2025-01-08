import 'dart:math' as math;

import 'package:flutter/material.dart';

class GuidelinesPainter extends CustomPainter {
  final double symmetryLines;
  final double penSize;
  final bool isMirror;
  final bool showGuidelines;

  GuidelinesPainter({
    required this.symmetryLines,
    required this.penSize,
    required this.showGuidelines,
    required this.isMirror,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!showGuidelines) return;

    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;

    final guidelinePaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final radius = math.min(halfWidth, halfHeight) - penSize;

    // Draw circle
    canvas.drawCircle(Offset(halfWidth, halfHeight), radius, guidelinePaint);

    // Draw symmetry lines
    double theta = isMirror ? 0 : -math.pi / symmetryLines;
    double x = halfWidth + math.sin(theta) * radius;
    double y = halfHeight - math.cos(theta) * radius;

    canvas.drawLine(
      Offset(halfWidth, halfHeight),
      Offset(x, y),
      guidelinePaint,
    );

    canvas.drawLine(
      Offset(halfWidth, halfHeight),
      Offset(
        halfWidth + math.sin(math.pi / symmetryLines) * radius,
        halfHeight - math.cos(math.pi / symmetryLines) * radius,
      ),
      guidelinePaint,
    );
  }

  @override
  bool shouldRepaint(GuidelinesPainter oldDelegate) {
    return oldDelegate.symmetryLines != symmetryLines ||
        oldDelegate.showGuidelines != showGuidelines ||
        oldDelegate.isMirror != isMirror;
  }
}
