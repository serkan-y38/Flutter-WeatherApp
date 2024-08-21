import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences _sharedPreferences;

  ThemeProvider(this._sharedPreferences);

  AppTheme? _currentTheme;

  AppTheme? get currentTheme => _currentTheme;

  Future<void> setTheme(AppTheme theme) async {
    await _sharedPreferences.setString(AppTheme.themeKey.name, theme.name);
    _currentTheme = theme;
    notifyListeners();
  }

  Future<void> getTheme() async {
    final theme = _sharedPreferences.getString(AppTheme.themeKey.name);
    if (theme != null) {
      if (theme == AppTheme.dark.name) {
        _currentTheme = AppTheme.dark;
      } else if (theme == AppTheme.light.name) {
        _currentTheme = AppTheme.light;
      } else {
        _currentTheme = AppTheme.systemSetting;
      }
    } else {
      _currentTheme = AppTheme.systemSetting;
    }
    notifyListeners();
  }
}
