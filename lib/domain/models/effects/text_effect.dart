import 'dart:math';

import 'package:doddle/application/providers/brush_settings_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_state.dart';
import 'package:doddle/main.dart';
import 'package:flutter/material.dart';

class TextEffect extends PenEffect {
  BrushSettingsState get settings =>
      globalRef.read(brushSettingsProvider(PenTool.textPen));

  String get text => settings.getValue('text') ?? 'Hello';
  double get fontSize => settings.getValue('fontSize') ?? 20.0;
  bool get randomRotation => settings.getValue('randomRotation') ?? false;
  double get wordSpacing => settings.getValue('wordSpacing') ?? 0.0;
  double get letterSpacing => settings.getValue('letterSpacing') ?? 0.0;
  TextDirection? get textDirection {
    final text = settings.getValue('text') ?? '';
    // Check if text contains RTL characters
    final rtlPattern =
        RegExp(r'[\u0591-\u07FF\u200F\u202B\u202E\uFB1D-\uFDFD\uFE70-\uFEFC]');
    return rtlPattern.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    // if (drawController.points?.isEmpty ?? true) return;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: drawController.currentColor,
          fontSize: fontSize,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        ),
      ),
      textDirection: textDirection ?? TextDirection.rtl,
    );
    textPainter.layout();

    for (var point in drawController.points!) {
      if (point?.offset == null) continue;

      final positions = getSymmetricalPositions(point!.offset!);

      for (var position in positions) {
    textPainter.layout();

        textPainter.paint(canvas, position);
      }
    }
  }
}
