import 'package:doddle/application/providers/brush_settings_provider.dart';
import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/point.dart';
import 'dart:math' as math;

class BrushPreviewPainter extends CustomPainter {
  final WidgetRef ref;
  
  BrushPreviewPainter(this.ref);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    final currentPenTool = ref.read(canvasNotifierProvider).penTool;
    
    // Special handling for text brush preview
    // if (currentPenTool == PenTool.textPen) {
    //   _drawTextPreview(canvas, size);
    // } else {
      // Original wave preview for other brushes
      final points = _generatePreviewPoints(size);
      final controller = DrawController(
        points: points,
        penTool: currentPenTool,
        penSize: ref.read(canvasNotifierProvider).penSize,
        currentColor: ref.read(canvasNotifierProvider).currentColor,
        effects: ref.read(canvasNotifierProvider).effects,
      );

      final effect = controller.effects[controller.penTool];
      
      if (effect != null) {
        Path path = Path();
        Paint paint = Paint()
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = controller.penSize ?? 2.0;

        _drawPreviewPoints(canvas, path, paint, effect, points);
        effect.paint(canvas, path, paint);
      }
    // }

    canvas.restore();
  }

  void _drawTextPreview(Canvas canvas, Size size) {
    final settings = ref.read(brushSettingsProvider(PenTool.textPen));
    final text = settings.getValue('text') ?? 'Hello';
    final fontSize = settings.getValue('fontSize') ?? 20.0;
    final color = ref.read(canvasNotifierProvider).currentColor;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Draw multiple instances of text along a curved path
    for (double x = -size.width/3; x <= size.width/3; x += 50) {
      final y = math.sin(x * 0.1) * 20;
      
      canvas.save();
      canvas.translate(x, y);
      
      // Add slight rotation for visual interest
      canvas.rotate(math.sin(x * 0.05) * 0.3);
      
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      
      canvas.restore();
    }
  }

  List<Point?> _generatePreviewPoints(Size size) {
    final points = <Point?>[];
    final width = size.width * 0.4;
    
    for (double x = -width/2; x <= width/2; x += 60) {
      final y = math.sin(x * 0.1) * 20;
      points.add(Point(offset: Offset(x, y)));
    }
    return points;
  }

  void _drawPreviewPoints(Canvas canvas, Path path, Paint paint, PenEffect effect, List<Point?> points) {
    for (var j = 0; j < points.length - 1; j++) {
      final currentPoint = points[j]?.offset;
      final nextPoint = points[j + 1]?.offset;

      if (currentPoint != null && nextPoint != null) {
        final currentSymPoints = effect.getSymmetricalPositions(currentPoint);
        final nextSymPoints = effect.getSymmetricalPositions(nextPoint);

        for (var i = 0; i < currentSymPoints.length; i++) {
          path.moveTo(currentSymPoints[i].dx, currentSymPoints[i].dy);
          path.lineTo(nextSymPoints[i].dx, nextSymPoints[i].dy);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 