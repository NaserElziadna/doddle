import 'dart:ui';
import 'package:doddle/application/providers/brush_settings_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_state.dart';
import 'package:doddle/domain/models/point.dart';
import 'package:doddle/main.dart';
import 'package:doddle/domain/models/effects/pen_effect.dart';
import 'dart:math' as math;

class SprayDot {
  final Offset position;
  final double opacity;
  final double size;
  final Color color;

  SprayDot({
    required this.position,
    required this.opacity,
    required this.size,
    required this.color,
  });
}

class SprayEffect extends PenEffect {
  final random = math.Random();
  List<SprayDot> sprayDots = [];

  BrushSettingsState get settings => globalRef.read(brushSettingsProvider(PenTool.sprayPen));

  double get density => settings.getValue('density') ?? 10;
  double get spread => settings.getValue('spread') ?? 10;
  double get opacity => settings.getValue('opacity') ?? 0.3;
  bool get randomizeEachDot => settings.getValue('randomizeEachDot') ?? false;

  @override
  void paint(Canvas canvas, Path path, Paint paint) {
    print('density: $density, spread: $spread, opacity: $opacity');

    for (var dot in sprayDots) {
      // Get all symmetrical positions for this dot
      final symmetricalDots = getSymmetricalPositions(dot.position);


      // Draw a dot at each symmetrical position
      for (var position in symmetricalDots) {
        canvas.drawCircle(position, dot.size * (drawController.penSize ?? 2.0),
            paint..color = dot.color.withValues(alpha:dot.opacity));
      }
    }
  }

  @override
  void onPointAdd(Point point) {
    if (point.offset == null) return;


    final numDots = density.toInt();
    for (int i = 0; i < numDots; i++) {
      final randomOffset = Offset(random.nextDouble() * spread - spread / 2,
          random.nextDouble() * spread - spread / 2);

      final color = randomizeEachDot
          ? getRandomColor()
          : (drawController.isRandomColor
              ? getRandomColor()
              : drawController.currentColor);

      addSprayDots([
        SprayDot(
          position: point.offset! + randomOffset,
          opacity: random.nextDouble() * opacity,
          size: random.nextDouble() * 0.5 + 0.5,
          color: color,
        ),
      ]);
    }
  }

  @override
  void onPointEnd() {
    sprayDots = [];
  }

  void addSprayDots(List<SprayDot> dots) {
    sprayDots = [...sprayDots, ...dots];
  }
}
