import 'package:flutter/material.dart';

/// Notifies the platform UI of the current theme so the user sees the change
/// immediately, and persists the choice.
class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(this._themeMode);

  ThemeMode _themeMode;

  ThemeMode getThemeMode() => _themeMode;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }
}
