import 'package:flutter/material.dart';

import '../utils/constant.dart';
import 'app_color.dart';

/// App themes.
///
/// Flat design: no elevation anywhere, small radii, and every surface defined
/// by a fill plus a hairline outline rather than a drop shadow. The theme only
/// provides base surfaces, typography and component shapes; each screen layers
/// its own [ToolPalette] accent on top.
class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final Color background = isDark ? AppColors.darkBg : AppColors.lightBg;
    final Color surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final Color surfaceAlt =
        isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;
    final Color border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final Color onSurface = isDark ? AppColors.textLight : AppColors.textDark;
    final Color muted =
        isDark ? AppColors.textMutedLight : AppColors.textMutedDark;

    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.brand,
      brightness: brightness,
    ).copyWith(
      surface: surface,
      onSurface: onSurface,
      primary: AppColors.brand,
      secondary: AppColors.brandAlt,
      outline: border,
      surfaceContainerHighest: surfaceAlt,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      splashFactory: InkSparkle.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: AppColors.brand.withValues(alpha: 0.06),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        bodyMedium: TextStyle(fontSize: 15, color: onSurface),
        bodySmall: TextStyle(fontSize: 13, color: muted),
      ).apply(
        fontFamily: fontAudioWide,
        // Audiowide is a display face: it has no glyphs for the calculator
        // symbols (U+22EF, U+232B, U+221A, U+03C0, U+00B1, superscripts), so
        // without a fallback those keys render blank on device.
        fontFamilyFallback: const <String>[fontSymbolFallback],
        bodyColor: onSurface,
        displayColor: onSurface,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: onSurface,
        titleTextStyle: TextStyle(
          fontFamily: fontAudioWide,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        iconTheme: IconThemeData(color: onSurface),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.allLg,
          side: BorderSide(color: border, width: AppBorders.hairline),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: border,
        thickness: AppBorders.hairline,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: AppRadii.allMd,
          borderSide: BorderSide(color: border, width: AppBorders.hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.allMd,
          borderSide: BorderSide(color: border, width: AppBorders.hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.allMd,
          borderSide: const BorderSide(
            color: AppColors.brand,
            width: AppBorders.strong,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
        hintStyle: TextStyle(color: muted, fontWeight: FontWeight.w600),
      ),
      iconTheme: IconThemeData(color: onSurface),
      listTileTheme: ListTileThemeData(
        iconColor: onSurface,
        textColor: onSurface,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.allMd),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: isDark ? AppColors.darkSurfaceAlt : AppColors.textDark,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.allMd,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.lg),
          ),
          side: BorderSide(width: 0),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.allLg,
          side: BorderSide(color: border, width: AppBorders.hairline),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.brand,
        linearTrackColor: border,
        circularTrackColor: border,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brand,
        selectionColor: AppColors.brand.withValues(alpha: 0.22),
        selectionHandleColor: AppColors.brand,
      ),
    );
  }
}
