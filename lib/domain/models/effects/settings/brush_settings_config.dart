import 'package:doddle/domain/models/draw_controller.dart';
import 'package:flutter/material.dart';

enum SettingType {
  slider,
  toggle,
  color,
  text,
  // Add more types as needed
}

class BrushSettingConfig {
  final String label;
  final SettingType type;
  final dynamic defaultValue;
  final dynamic minValue;
  final dynamic maxValue;
  final int? divisions;
  final IconData? icon;

  const BrushSettingConfig({
    required this.label,
    required this.type,
    required this.defaultValue,
    this.minValue,
    this.maxValue,
    this.divisions,
    this.icon,
  });
}

class BrushConfig {
  final Map<String, BrushSettingConfig> settings;
  final String name;
  final String description;

  const BrushConfig({
    required this.name,
    required this.settings,
    this.description = '',
  });
}

// Define configurations for each brush type
class BrushConfigs {
  static final Map<PenTool, BrushConfig> configs = {
    PenTool.normalPen: BrushConfig(
      name: 'Normal Brush',
      settings: {}, // Normal pen has no special settings, just uses the base color and size
    ),
    PenTool.glowWithDotsPen: BrushConfig(
      name: 'Glow with Dots Brush',
      settings: {
        'dashLength': BrushSettingConfig(
          label: 'Dash Length',
          type: SettingType.slider,
          defaultValue: 5.0,
          minValue: 1.0,
          maxValue: 20.0,
          icon: Icons.horizontal_rule,
        ),
        'gapLength': BrushSettingConfig(
          label: 'Gap Length',
          type: SettingType.slider,
          defaultValue: 10.0,
          minValue: 1.0,
          maxValue: 30.0,
          icon: Icons.space_bar,
        ),
        'glowRadius': BrushSettingConfig(
          label: 'Glow Radius',
          type: SettingType.slider,
          defaultValue: 5.0,
          minValue: 0.0,
          maxValue: 20.0,
          icon: Icons.blur_on,
        ),
      },
    ),
    PenTool.sprayPen: BrushConfig(
      name: 'Spray Brush',
      settings: {
        'density': BrushSettingConfig(
          label: 'Density',
          type: SettingType.slider,
          defaultValue: 10.0,
          minValue: 1.0,
          maxValue: 30.0,
          icon: Icons.grain,
        ),
        'spread': BrushSettingConfig(
          label: 'Spread',
          type: SettingType.slider,
          defaultValue: 10.0,
          minValue: 1.0,
          maxValue: 50.0,
          icon: Icons.radio_button_unchecked,
        ),
        'opacity': BrushSettingConfig(
          label: 'Opacity',
          type: SettingType.slider,
          defaultValue: 0.3,
          minValue: 0.1,
          maxValue: 1.0,
          icon: Icons.opacity,
        ),
        'randomizeEachDot': BrushSettingConfig(
          label: 'Randomize Each Dot',
          type: SettingType.toggle,
          defaultValue: false,
          icon: Icons.color_lens,
        ),
      },
    ),
    PenTool.glowPen: BrushConfig(
      name: 'Glow Brush',
      settings: {
        'intensity': BrushSettingConfig(
          label: 'Glow Intensity',
          type: SettingType.slider,
          defaultValue: 0.5,
          minValue: 0.1,
          maxValue: 1.0,
          icon: Icons.brightness_medium,
        ),
        'blur': BrushSettingConfig(
          label: 'Blur Amount',
          type: SettingType.slider,
          defaultValue: 3.0,
          minValue: 1.0,
          maxValue: 10.0,
          icon: Icons.blur_on,
        ),
        'outerGlow': BrushSettingConfig(
          label: 'Outer Glow Size',
          type: SettingType.slider,
          defaultValue: 5.0,
          minValue: 0.0,
          maxValue: 20.0,
          icon: Icons.radio_button_unchecked,
        ),
        'innerGlow': BrushSettingConfig(
          label: 'Inner Glow',
          type: SettingType.toggle,
          defaultValue: true,
          icon: Icons.circle,
        ),
        'rainbow': BrushSettingConfig(
          label: 'Rainbow Mode',
          type: SettingType.toggle,
          defaultValue: false,
          icon: Icons.color_lens,
        ),
      },
    ),
    PenTool.textPen: BrushConfig(
      name: 'Text Brush',
      description: 'Draw with text characters',
      settings: {
        'text': BrushSettingConfig(
          label: 'Text',
          type: SettingType.text,
          defaultValue: 'Hello',
          icon: Icons.text_fields,
        ),
        'fontSize': BrushSettingConfig(
          label: 'Font Size',
          type: SettingType.slider,
          defaultValue: 20.0,
          minValue: 8.0,
          maxValue: 72.0,
          icon: Icons.format_size,
        ),
        'wordSpacing': BrushSettingConfig(
          label: 'Word Spacing',
          type: SettingType.slider,
          defaultValue: 50.0,
          minValue: 10.0,
          maxValue: 200.0,
          icon: Icons.space_bar,
        ),
        'letterSpacing': BrushSettingConfig(
          label: 'Letter Spacing',
          type: SettingType.slider,
          defaultValue: 0.0,
          minValue: -50.0,
          maxValue: 50.0,
          icon: Icons.space_bar,
        ),
        'randomRotation': BrushSettingConfig(
          label: 'Random Rotation',
          type: SettingType.toggle,
          defaultValue: false,
          icon: Icons.rotate_right,
        ),
      },
    ),
    // Add more brush configurations...
  };
}
