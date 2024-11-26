import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/application/providers/canvas/canvas_provider.dart';

class CanvasSettingsToolGrid extends ConsumerWidget {
  const CanvasSettingsToolGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawController = ref.watch(canvasProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSliderSection(
            'Stroke Width',
            drawController.penSize ?? 2.0,
            1.0,
            50.0,
            (value) => ref.read(canvasProvider.notifier).changePenSize(value),
          ),
          const SizedBox(height: 16),
          _buildSwitchRow(
            'Mirror Symmetry',
            drawController.mirrorSymmetry,
            (value) => ref.read(canvasProvider.notifier).toggleMirrorSymmetry(value),
          ),
          const SizedBox(height: 8),
          _buildSwitchRow(
            'Show Guidelines',
            drawController.showGuidelines,
            (value) => ref.read(canvasProvider.notifier).toggleGuidelines(value),
          ),          
        ],
      ),
    );
  }

  Widget _buildSliderSection(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged, {
    int? divisions,
    bool showDivisions = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            Text(
              showDivisions ? value.toInt().toString() : value.toStringAsFixed(1),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: showDivisions ? value.round().toString() : null,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchRow(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
