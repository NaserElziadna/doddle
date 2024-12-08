import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/custom_pen_effect.dart';
import 'package:doddle/domain/models/effects/eraser_effect.dart';
import 'package:doddle/domain/models/effects/glow_effect.dart';
import 'package:doddle/domain/models/effects/glow_with_dots_effect.dart';
import 'package:doddle/domain/models/effects/normal_effect.dart';
import 'package:doddle/domain/models/effects/normal_with_shader_effect.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'package:doddle/domain/models/effects/spray_effect.dart';
import 'package:doddle/domain/models/effects/text_effect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final effectsProvider = Provider<Map<PenTool, PenEffect>>((ref) {
  // final canvas = ref.watch(canvasNotifierProvider);
  return {
    PenTool.customPen: CustomPenEffect(),
    PenTool.eraserPen: EraserEffect(),
    PenTool.sprayPen: SprayEffect(),
    PenTool.glowPen: GlowEffect(),
    PenTool.normalPen: NormalEffect(),
    PenTool.normalWithShaderPen: NormalWithShaderEffect(),
    PenTool.glowWithDotsPen: GlowWithDotsEffect(),
    PenTool.textPen: TextEffect(),
  };
}); 