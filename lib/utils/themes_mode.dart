import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_color.dart';

/// Tracks whether the app is currently rendering in dark mode and keeps the
/// system status / navigation bars in sync with it.
abstract final class ThemesMode {
  static bool isDarkMode = false;

  /// Call once per `build` with the current context. Safe to call repeatedly.
  static void sync(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color bar = isDarkMode ? AppColors.darkBg : AppColors.lightBg;
    final Brightness iconBrightness =
        isDarkMode ? Brightness.light : Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconBrightness,
        systemNavigationBarColor: bar,
        systemNavigationBarIconBrightness: iconBrightness,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  /// Primary foreground colour for the current theme.
  static Color get onSurface =>
      isDarkMode ? AppColors.textLight : AppColors.textDark;

  /// Secondary / caption foreground colour for the current theme.
  static Color get onSurfaceMuted =>
      isDarkMode ? AppColors.textMutedLight : AppColors.textMutedDark;

  /// Card background for the current theme.
  static Color get surface =>
      isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;

  /// Page background for the current theme.
  static Color get background =>
      isDarkMode ? AppColors.darkBg : AppColors.lightBg;

  /// Low-emphasis fill used for inputs, chips and inert tiles.
  static Color get subtleFill =>
      isDarkMode ? AppColors.darkSurfaceAlt : const Color(0xFFEDEFF7);
}
