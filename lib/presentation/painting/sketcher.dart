import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/custom_pen_effect.dart';
import 'package:doddle/domain/models/effects/eraser_effect.dart';
import 'package:doddle/domain/models/effects/glow_effect.dart';
import 'package:doddle/domain/models/effects/glow_with_dots_effect.dart';
import 'package:doddle/domain/models/effects/normal_effect.dart';
import 'package:doddle/domain/models/effects/normal_with_shader_effect.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:doddle/domain/models/effects/spray_effect.dart';
import 'package:doddle/domain/models/point.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

const pi = math.pi;

class Sketcher extends CustomPainter {
   final DrawController controller;
  final WidgetRef ref;
  final Map<PenTool, PenEffect> _effects;

  
  Sketcher(this.controller, this.ref) : _effects = {
    PenTool.customPen: CustomPenEffect()..initialize(ref),
    PenTool.eraserPen: EraserEffect()..initialize(ref),
    PenTool.sprayPen: SprayEffect()..initialize(ref),
    PenTool.glowPen: GlowEffect()..initialize(ref),
    PenTool.normalPen: NormalEffect()..initialize(ref),
    PenTool.normalWithShaderPen: NormalWithShaderEffect()..initialize(ref),
    PenTool.glowWithDotsPen: GlowWithDotsEffect()..initialize(ref),

    // Initialize other effects
  };

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }

   @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    final effect = _effects[controller.penTool];
    if (effect != null) {
      Path path = Path();
      Paint paint = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = controller.penSize ?? 2.0;
        
      _drawPoints(canvas, path, paint);
      effect.paint(canvas, path, paint);
    }

    canvas.restore();
  }

  List<Offset> _getSymmetryPoints(Offset point) {
    final relX = point.dx;
    final relY = point.dy;
    final dist = math.sqrt(relX * relX + relY * relY);
    final angle = math.atan2(relX, relY);

    List<Offset> result = [];
    for (int i = 0; i < controller.symmetryLines!; i++) {
      final theta = angle + 2 * pi * i / controller.symmetryLines!;
      final x = math.sin(theta) * dist;
      final y = math.cos(theta) * dist;
      result.add(Offset(x, y));

      if (controller.mirrorSymmetry) {
        result.add(Offset(-x, y));
      }
    }
    return result;
  }

  void _drawPoints(Canvas canvas, Path path, Paint paint) {
    for (var j = 0; j < controller.points!.length - 1; j++) {
      if (controller.points![j + 1] == null) {
        j++;
        continue;
      }

      final currentPoint = controller.points![j]?.offset;
      final nextPoint = controller.points![j + 1]?.offset;

      if (currentPoint != null && nextPoint != null) {
        // Get all symmetry points for both current and next points
        final currentSymPoints = _getSymmetryPoints(currentPoint);
        final nextSymPoints = _getSymmetryPoints(nextPoint);

        // Draw lines between corresponding symmetry points
        for (var i = 0; i < currentSymPoints.length; i++) {
          path.moveTo(currentSymPoints[i].dx, currentSymPoints[i].dy);
          path.lineTo(nextSymPoints[i].dx, nextSymPoints[i].dy);
        }
      }
    }
  }
}
