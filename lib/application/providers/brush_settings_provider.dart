import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/models/effects/settings/brush_settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brushSettingsProvider = StateNotifierProvider.family<BrushSettingsNotifier, BrushSettingsState, PenTool>((ref, penTool) {
  return BrushSettingsNotifier(penTool);
});

class BrushSettingsNotifier extends StateNotifier<BrushSettingsState> {
  BrushSettingsNotifier(PenTool penTool) : super(BrushSettingsState(penTool: penTool));

  void updateSetting(String key, dynamic value) {
    state = state.copyWith(
      values: {...state.values, key: value},
    );
  }

  void resetToDefault() {
    state = BrushSettingsState(penTool: state.penTool);
  }
} 