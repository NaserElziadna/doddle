import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_config.dart';
import 'package:doddle/application/providers/brush_settings_provider.dart';
import 'package:doddle/presentation/common/widgets/brush_settings/brush_viewer.dart';

class BrushSettingsPanel extends ConsumerWidget {
  const BrushSettingsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPenTool = ref.watch(canvasNotifierProvider).penTool;
    if (currentPenTool == null) return const SizedBox.shrink();

    final brushConfig = BrushConfigs.configs[currentPenTool];
    if (brushConfig == null) return const SizedBox.shrink();

    final settings = ref.watch(brushSettingsProvider(currentPenTool));

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            brushConfig.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (brushConfig.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              brushConfig.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 16),
          const BrushPreview(),
          const SizedBox(height: 16),
          ...brushConfig.settings.entries.map((entry) {
            return _buildSettingControl(
              context,
              ref,
              currentPenTool,
              entry.key,
              entry.value,
              settings.getValue(entry.key),
            );
          }),
          const SizedBox(height: 16),
          _buildResetButton(context, ref, currentPenTool),
        ],
      ),
    );
  }

  Widget _buildSettingControl(
    BuildContext context,
    WidgetRef ref,
    PenTool penTool,
    String key,
    BrushSettingConfig config,
    dynamic currentValue,
  ) {
    switch (config.type) {
      case SettingType.slider:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (config.icon != null) ...[
                    Icon(config.icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(config.label),
                  const Spacer(),
                  Text(currentValue.toStringAsFixed(1)),
                ],
              ),
              Slider(
                value: currentValue,
                min: config.minValue,
                max: config.maxValue,
                divisions: config.divisions,
                onChanged: (value) {
                  ref.read(brushSettingsProvider(penTool).notifier)
                    .updateSetting(key, value);
                },
              ),
            ],
          ),
        );
      case SettingType.toggle:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              if (config.icon != null) ...[
                Icon(config.icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(config.label),
              const Spacer(),
              Switch.adaptive(
                value: currentValue ?? false,
                onChanged: (value) {
                  ref.read(brushSettingsProvider(penTool).notifier)
                    .updateSetting(key, value);
                },
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildResetButton(BuildContext context, WidgetRef ref, PenTool penTool) {
    return Center(
      child: TextButton.icon(
        icon: const Icon(Icons.restart_alt),
        label: const Text('Reset to Default'),
        onPressed: () {
          ref.read(brushSettingsProvider(penTool).notifier).resetToDefault();
        },
      ),
    );
  }
} 