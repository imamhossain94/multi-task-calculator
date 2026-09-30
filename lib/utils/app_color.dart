import 'package:flutter/material.dart';

import 'constant.dart';

/// Corner radii.
///
/// Deliberately small. Material 3 leans on 12-28 px pills; this design uses
/// 3-8 px so the app reads as flat and precise rather than soft and bubbly.
abstract final class AppRadii {
  /// Tiny elements: chips, dots.
  static const double xs = 3;

  /// Dense rows, small keys.
  static const double sm = 4;

  /// Default: fields, buttons, tiles.
  static const double md = 6;

  /// Cards, sheets, dialogs.
  static const double lg = 8;

  static const BorderRadius allXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius allSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius allMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius allLg = BorderRadius.all(Radius.circular(lg));
}

/// A 4 px spacing scale. Every gap in the app is one of these.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Standard outer page margin.
  static const double page = 16;

  /// Standard gap between sibling cards.
  static const double stack = 12;
}

/// Border weights.
abstract final class AppBorders {
  /// Resting outline.
  static const double hairline = 1;

  /// Emphasised outline: selected chips, focused fields.
  static const double strong = 1.5;
}

/// Core colour tokens.
///
/// The surface set is intentionally achromatic so that colour comes only from
/// the per-tool [ToolPalette] accent, never from the background.
abstract final class AppColors {
  // ------------------------------------------------------------------ brand
  static const Color brand = Color(0xFF2F5BEA);
  static const Color brandAlt = Color(0xFF6C3CE9);

  // --------------------------------------------------------------- surfaces
  static const Color lightBg = Color(0xFFF6F7F9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEEF0F4);
  static const Color lightBorder = Color(0xFFDCE0E7);

  static const Color darkBg = Color(0xFF111317);
  static const Color darkSurface = Color(0xFF1A1D22);
  static const Color darkSurfaceAlt = Color(0xFF242830);
  static const Color darkBorder = Color(0xFF303640);

  // -------------------------------------------------------------------- text
  static const Color textDark = Color(0xFF14171C);
  static const Color textMutedDark = Color(0xFF6B7280);
  static const Color textLight = Color(0xFFF3F4F6);
  static const Color textMutedLight = Color(0xFF9AA1AC);

  // ------------------------------------------------------------- semantic
  static const Color success = Color(0xFF0E9F6E);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);
  static const Color info = Color(0xFF2F5BEA);

  // --------------------------------------------------------- legacy tokens
  // Kept so older call sites keep compiling. Prefer [AppColors].
  static const Color textBlack = Colors.black;
  static const Color textWhite = Colors.white;
  static const Color textBlue = brand;
  static const Color textYellow = Color(0xFFFFCF18);
  static const Color textGreen = Color(0xFF0E9F6E);
  static const Color textRed = danger;
  static const Color textMaroon = Color(0xFFB42807);
  static const Color textAmber = Colors.amber;
  static const Color textOrange = Colors.orange;
  static const Color backgroundLight = lightBg;
  static const Color backgroundDark = darkBg;
}

/// The visual identity of a single calculator: one flat accent colour.
///
/// No gradients and no shadows — the accent is used as a solid fill, as an
/// outline, or as a low-alpha tint, depending on the component.
@immutable
class ToolPalette {
  const ToolPalette(this.accent);

  /// The tool's single colour.
  final Color accent;

  /// Text/icon colour that sits on top of a solid [accent] fill.
  Color get onAccent => Colors.white;

  /// Low-alpha accent for inactive chips and selected-row highlights.
  Color soft(bool isDark, [double light = 0.10, double dark = 0.18]) =>
      accent.withValues(alpha: isDark ? dark : light);

  /// Mid-alpha accent, for hover/pressed states.
  Color medium(bool isDark, [double light = 0.18, double dark = 0.28]) =>
      accent.withValues(alpha: isDark ? dark : light);

  /// Accent at full strength, for outlines.
  Color strong(bool isDark, [double light = 0.55, double dark = 0.65]) =>
      accent.withValues(alpha: isDark ? dark : light);
}

/// Per-tool palettes. Every screen looks up its palette by route name so the
/// home tile, the app bar and the result cards always agree.
abstract final class AppPalettes {
  static const ToolPalette general = ToolPalette(Color(0xFF2F5BEA));
  static const ToolPalette currency = ToolPalette(Color(0xFF0891B2));
  static const ToolPalette unitConverter = ToolPalette(Color(0xFF7C3AED));
  static const ToolPalette numberBase = ToolPalette(Color(0xFF475569));
  static const ToolPalette discount = ToolPalette(Color(0xFFEA580C));
  static const ToolPalette tip = ToolPalette(Color(0xFF059669));
  static const ToolPalette date = ToolPalette(Color(0xFF2563EB));
  static const ToolPalette fuelCost = ToolPalette(Color(0xFFDC2626));
  static const ToolPalette fuelEfficiency = ToolPalette(Color(0xFF4D7C0F));
  static const ToolPalette health = ToolPalette(Color(0xFFDB2777));
  static const ToolPalette loan = ToolPalette(Color(0xFF1D4ED8));
  static const ToolPalette salesTax = ToolPalette(Color(0xFF047857));
  static const ToolPalette savings = ToolPalette(Color(0xFFB45309));
  static const ToolPalette unitPrice = ToolPalette(Color(0xFF0F766E));
  static const ToolPalette history = ToolPalette(Color(0xFF4F46E5));
  static const ToolPalette support = ToolPalette(Color(0xFFDB2777));
  static const ToolPalette neutral = ToolPalette(Color(0xFF52606D));

  static const ToolPalette info = ToolPalette(AppColors.info);
  static const ToolPalette success = ToolPalette(AppColors.success);
  static const ToolPalette warning = ToolPalette(AppColors.warning);
  static const ToolPalette danger = ToolPalette(AppColors.danger);

  /// Route name -> palette. Anything missing falls back to [neutral].
  static Map<String, ToolPalette> get byRoute => <String, ToolPalette>{
        generalCalcPage: general,
        currencyCalcPage: currency,
        unitConverterPage: unitConverter,
        unitConverterChildPage: unitConverter,
        numberBaseConverterPage: numberBase,
        discountCalcPage: discount,
        tipCalcPage: tip,
        dateCalcPage: date,
        fuelCalcPage: fuelCost,
        fuelEfficiencyCalcPage: fuelEfficiency,
        healthCalcPage: health,
        loanCalcPage: loan,
        salesTaxCalcPage: salesTax,
        savingCalcPage: savings,
        unitPriceCalcPage: unitPrice,
        historyPage: history,
        aboutPage: info,
        helpPage: info,
        feedbackPage: support,
        updateCheckPage: neutral,
        premiumPage: support,
      };

  static ToolPalette of(String route) => byRoute[route] ?? neutral;
}
