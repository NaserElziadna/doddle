import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Provider for SharedPreferences service
final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesService(sharedPrefs);
});

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  // Theme related
  static const String _themeKey = 'theme_mode';

  // Get theme mode
  String? getThemeMode() {
    return _prefs.getString(_themeKey);
  }

  // Save theme mode
  Future<bool> setThemeMode(String theme) async {
    return await _prefs.setString(_themeKey, theme);
  }

  // Canvas related
  static const String _strokeWidthKey = 'stroke_width';
  static const String _selectedColorKey = 'selected_color';

  double getStrokeWidth() {
    return _prefs.getDouble(_strokeWidthKey) ?? 2.0;
  }

  Future<bool> setStrokeWidth(double width) async {
    return await _prefs.setDouble(_strokeWidthKey, width);
  }

  int? getSelectedColor() {
    return _prefs.getInt(_selectedColorKey);
  }

  Future<bool> setSelectedColor(int color) async {
    return await _prefs.setInt(_selectedColorKey, color);
  }

  // Clear all preferences
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
