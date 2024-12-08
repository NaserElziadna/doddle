import 'dart:math';

import 'package:doddle/application/providers/brush_settings_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_state.dart';
import 'package:doddle/main.dart';
import 'package:flutter/material.dart';

class TextEffect extends PenEffect {
  BrushSettingsState get settings => globalRef.read(brushSettingsProvider(PenTool.textPen));
  
  String get text => settings.getValue('text') ?? 'Hello';
  double get fontSize => settings.getValue('fontSize') ?? 20.0;
  bool get randomRotation => settings.getValue('randomRotation') ?? false;
  double get spacing => settings.getValue('spacing') ?? 50.0;

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    // if (drawController.points?.isEmpty ?? true) return;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: drawController.currentColor,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    for (var point in drawController.points!) {
      if (point?.offset == null) continue;
      
      final positions = getSymmetricalPositions(point!.offset!);
      
      for (var position in positions) {
        canvas.save();
        canvas.translate(position.dx, position.dy);
        
        if (randomRotation) {
          
          final rotation = (point.pressure ?? 0) * 2 * pi;
          canvas.rotate(rotation);
        }
        
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );
        
        canvas.restore();
      }
    }
  }
} 