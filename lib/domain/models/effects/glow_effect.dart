import 'package:doddle/application/providers/brush_settings_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_state.dart';
import 'package:doddle/main.dart';
import 'package:flutter/material.dart';

class GlowEffect extends PenEffect {
  BrushSettingsState get settings => globalRef.read(brushSettingsProvider(PenTool.glowPen));
  double get intensity => settings.getValue('intensity') ?? 0.5;
  double get blur => settings.getValue('blur') ?? 3.0;
  double get outerGlow => settings.getValue('outerGlow') ?? 5.0;
  bool get innerGlow => settings.getValue('innerGlow') ?? true;
  bool get rainbow => settings.getValue('rainbow') ?? false;

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    // Draw outer glow
    if (outerGlow > 0) {
      canvas.drawPath(
        path,
        Paint()
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur)
          ..color = rainbow ? _getRainbowColor() : drawController.currentColor.withOpacity(intensity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = drawController.penSize! + outerGlow,
      );
    }

    // Draw inner glow if enabled
    if (innerGlow) {
      canvas.drawPath(
        path,
        Paint()
          ..maskFilter = MaskFilter.blur(BlurStyle.inner, blur * 0.5)
          ..color = rainbow ? _getRainbowColor() : drawController.currentColor.withOpacity(intensity * 0.7)
          ..style = PaintingStyle.stroke
          ..strokeWidth = drawController.penSize!,
      );
    }

    // Draw the main stroke
    canvas.drawPath(
      path,
      paint
        ..color = Colors.white
        ..strokeWidth = drawController.penSize! * 0.8,
    );
  }

  Color _getRainbowColor() {
    final hue = (DateTime.now().millisecondsSinceEpoch / 50) % 360;
    return HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
  }
}
