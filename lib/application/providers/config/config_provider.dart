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
} 