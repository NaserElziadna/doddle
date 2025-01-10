import 'package:doddle/application/providers/brush_settings_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_state.dart';
import 'package:doddle/main.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class GlowWithDotsEffect extends PenEffect {
  BrushSettingsState get settings =>
      globalRef.read(brushSettingsProvider(PenTool.glowWithDotsPen));
  double get dashLength => settings.getValue('dashLength') ?? 5.0;
  double get gapLength => settings.getValue('gapLength') ?? 10.0;
  double get glowRadius => settings.getValue('glowRadius') ?? 5.0;

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    final pathWithDots = dashPath(
      path,
      dashArray: CircularIntervalList<double>(
          <double>[5, 10]), // Changed to create 5px dashes with 10px gaps
    );

    canvas.drawPath(
        pathWithDots,
        Paint()
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowRadius)
          ..color = drawController.currentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = drawController.penSize!);

    canvas.drawPath(
        pathWithDots,
        paint
          ..strokeWidth = drawController.penSize!
          ..color = Colors.white);
  }
}
