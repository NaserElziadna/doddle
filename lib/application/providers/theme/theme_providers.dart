import 'package:doddle/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});


//theme service

class ThemeService {
  ThemeData getTheme(ThemeMode themeMode) {
    return themeMode == ThemeMode.light ? appTheme : appTheme;
  }
}
