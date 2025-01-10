import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_config.dart';

class BrushSettingsState {
  final Map<String, dynamic> values;
  final PenTool penTool;

  BrushSettingsState({
    required this.penTool,
    Map<String, dynamic>? values,
  }) : values = values ?? _getDefaultValues(penTool);

  static Map<String, dynamic> _getDefaultValues(PenTool penTool) {
    final config = BrushConfigs.configs[penTool];
    if (config == null) return {};

    return Map.fromEntries(
      config.settings.entries.map(
        (e) => MapEntry(e.key, e.value.defaultValue),
      ),
    );
  }

  BrushSettingsState copyWith({
    Map<String, dynamic>? values,
  }) {
    return BrushSettingsState(
      penTool: penTool,
      values: values ?? this.values,
    );
  }

  dynamic getValue(String key) => values[key];
}
