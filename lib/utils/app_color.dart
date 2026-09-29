import 'package:flutter/material.dart';

import 'constant.dart';

/// Core colour tokens for the app.
///
/// The palette is intentionally small: every screen derives its personality
/// from a per-tool [ToolPalette] (gradient + accent) rather than from
/// hard-coded colours scattered across widgets.
abstract final class AppColors {
  // ---------------------------------------------------------------- brand
  static const Color brand = Color(0xFF5B5BF0);
  static const Color brandAlt = Color(0xFF9B5BF0);

  // ------------------------------------------------------------- surfaces
  static const Color lightBg = Color(0xFFF4F5FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBg = Color(0xFF101122);
  static const Color darkSurface = Color(0xFF1B1D33);
  static const Color darkSurfaceAlt = Color(0xFF242743);

  // ---------------------------------------------------------------- text
  static const Color textDark = Color(0xFF14162B);
  static const Color textMutedDark = Color(0xFF6B6F8D);
  static const Color textLight = Color(0xFFF7F8FF);
  static const Color textMutedLight = Color(0xFF9BA0C4);

  // -------------------------------------------------------- semantic tints
  static const Color success = Color(0xFF12B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // -------------------------------------------------------- legacy tokens
  // Kept so the existing widget code keeps compiling. Prefer [AppColors]
  // for new code.
  static const Color textBlack = Colors.black;
  static const Color textWhite = Colors.white;
  static const Color textBlue = Color(0xFF2962FF);
  static const Color textYellow = Color(0xFFFFCF18);
  static const Color textGreen = Color(0xFF2EC4B6);
  static const Color textRed = Color(0xFFFF3030);
  static const Color textMaroon = Color(0xFFB42807);
  static const Color textAmber = Colors.amber;
  static const Color textOrange = Colors.orange;
  static const Color backgroundLight = lightBg;
  static const Color backgroundDark = darkBg;
}

/// The visual identity of a single calculator: a two-stop gradient used for
/// headers / result tiles / primary buttons, plus a matching flat accent.
@immutable
class ToolPalette {
  const ToolPalette({
    required this.gradient,
    required this.accent,
  });

  final List<Color> gradient;
  final Color accent;

  /// Horizontal gradient, used for cards and buttons.
  LinearGradient get linear => LinearGradient(
        colors: gradient,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  /// Diagonal gradient, used for banners and headers.
  LinearGradient get diagonal => LinearGradient(
        colors: gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

/// Per-tool palettes. Every screen looks up its palette by route name so that
/// the home tile, the page header and the result cards always agree.
abstract final class AppPalettes {
  static const ToolPalette general = ToolPalette(
    gradient: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    accent: Color(0xFF6366F1),
  );

  static const ToolPalette currency = ToolPalette(
    gradient: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    accent: Color(0xFF0EA5E9),
  );

  static const ToolPalette unitConverter = ToolPalette(
    gradient: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    accent: Color(0xFFA855F7),
  );

  static const ToolPalette numberBase = ToolPalette(
    gradient: [Color(0xFF475569), Color(0xFF6366F1)],
    accent: Color(0xFF64748B),
  );

  static const ToolPalette discount = ToolPalette(
    gradient: [Color(0xFFF97316), Color(0xFFF59E0B)],
    accent: Color(0xFFF97316),
  );

  static const ToolPalette tip = ToolPalette(
    gradient: [Color(0xFF10B981), Color(0xFF14B8A6)],
    accent: Color(0xFF10B981),
  );

  static const ToolPalette date = ToolPalette(
    gradient: [Color(0xFF3B82F6), Color(0xFF6366F1)],
    accent: Color(0xFF3B82F6),
  );

  static const ToolPalette fuelCost = ToolPalette(
    gradient: [Color(0xFFEF4444), Color(0xFFF97316)],
    accent: Color(0xFFEF4444),
  );

  static const ToolPalette fuelEfficiency = ToolPalette(
    gradient: [Color(0xFF84CC16), Color(0xFF10B981)],
    accent: Color(0xFF65A30D),
  );

  static const ToolPalette health = ToolPalette(
    gradient: [Color(0xFFF43F5E), Color(0xFFEC4899)],
    accent: Color(0xFFF43F5E),
  );

  static const ToolPalette loan = ToolPalette(
    gradient: [Color(0xFF1D4ED8), Color(0xFF0EA5E9)],
    accent: Color(0xFF1D4ED8),
  );

  static const ToolPalette salesTax = ToolPalette(
    gradient: [Color(0xFF059669), Color(0xFF22C55E)],
    accent: Color(0xFF059669),
  );

  static const ToolPalette savings = ToolPalette(
    gradient: [Color(0xFFF59E0B), Color(0xFFEAB308)],
    accent: Color(0xFFD97706),
  );

  static const ToolPalette unitPrice = ToolPalette(
    gradient: [Color(0xFF0D9488), Color(0xFF6366F1)],
    accent: Color(0xFF0D9488),
  );

  static const ToolPalette history = ToolPalette(
    gradient: [Color(0xFF6366F1), Color(0xFF06B6D4)],
    accent: Color(0xFF6366F1),
  );

  static const ToolPalette neutral = ToolPalette(
    gradient: [Color(0xFF64748B), Color(0xFF475569)],
    accent: Color(0xFF64748B),
  );

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
    updateCheckPage: neutral,
  };

  static ToolPalette of(String route) => byRoute[route] ?? neutral;
}
