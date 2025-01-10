import 'package:doddle/domain/value_objects/tool_types.dart';
import 'package:doddle/generated/assets.gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Main config provider
final configProvider = Provider<AppConfig>((ref) {
  return AppConfig.instance;
});

class AppConfig {
  static final AppConfig instance = AppConfig._internal();

  factory AppConfig() {
    return instance;
  }

  AppConfig._internal();

  // App information
  String get appName => 'Doddle';
  bool get isDebugMode => true;

  // Canvas settings
  double get defaultStrokeWidth => 2.0;
  int get maxUndoSteps => 20;
  double get minZoom => 0.5;
  double get maxZoom => 3.0;

  // Tool settings
  Map<String, dynamic> get defaultToolSettings => {
        'brush': {
          'minSize': 1.0,
          'maxSize': 50.0,
          'defaultSize': 10.0,
        },
        'eraser': {
          'minSize': 5.0,
          'maxSize': 100.0,
          'defaultSize': 20.0,
        },
      };

  // Performance settings
  int get maxFrameRate => 60;
  bool get enableHighPerformanceMode => true;

  // Symmetry settings
  List<SymmtriclLine> get symmetryLines => [
        SymmtriclLine(
            count: 1,
            picture: Assets.svg.symmetricalLine1.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 1,
            picture: Assets.svg.symmetricalLine2.svg(),
            isMirror: true),
        SymmtriclLine(
            count: 2,
            picture: Assets.svg.symmetricalLine3.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 2,
            picture: Assets.svg.symmetricalLine4.svg(),
            isMirror: true),
        SymmtriclLine(
            count: 3,
            picture: Assets.svg.symmetricalLine5.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 3,
            picture: Assets.svg.symmetricalLine6.svg(),
            isMirror: true),
        SymmtriclLine(
            count: 4,
            picture: Assets.svg.symmetricalLine7.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 4,
            picture: Assets.svg.symmetricalLine8.svg(),
            isMirror: true),
        SymmtriclLine(
            count: 5,
            picture: Assets.svg.symmetricalLine9.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 5,
            picture: Assets.svg.symmetricalLine10.svg(),
            isMirror: true),
        SymmtriclLine(
            count: 6,
            picture: Assets.svg.symmetricalLine11.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 6,
            picture: Assets.svg.symmetricalLine12.svg(),
            isMirror: true),
        SymmtriclLine(
            count: 7,
            picture: Assets.svg.symmetricalLine13.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 7,
            picture: Assets.svg.symmetricalLine14.svg(),
            isMirror: true),
        SymmtriclLine(
            count: 8,
            picture: Assets.svg.symmetricalLine15.svg(),
            isMirror: false),
        SymmtriclLine(
            count: 8,
            picture: Assets.svg.symmetricalLine16.svg(),
            isMirror: true),
      ];
}
