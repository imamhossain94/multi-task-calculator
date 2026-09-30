import 'package:flutter/material.dart';

import '../../../utils/screen_config.dart';
import 'build_calc_pad.dart' show CalcGlyphs;
import '../../../utils/themes_mode.dart';
import '../../../components/app_surface.dart';
import '../../../utils/app_color.dart';

/// A single key on the general calculator pad.
///
/// Flat: digits are a plain surface with a hairline outline, operator keys
/// are a solid block of the tool's accent. No gradient, no shadow.
class BuildCalcButton extends StatelessWidget {
  const BuildCalcButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.buttonColor,
    this.textColor,
  });

  final String title;

  /// Rendered instead of [title] when set.
  ///
  /// The "more" and "backspace" keys use icons rather than the U+22EF /
  /// U+232B glyphs: those code points are absent from Audiowide, so the text
  /// version depended entirely on the theme's font fallback to stay legible.
  final IconData? icon;

  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback onPressed;

  /// Operator / bracket / clear keys are rendered in the brand colour.
  bool get _isFunction => _functionKeys.contains(title);

  static final Set<String> _functionKeys = <String>{
    CalcGlyphs.more,
    '(',
    ')',
    CalcGlyphs.backspace,
    'C',
    '%',
    CalcGlyphs.powerOf,
    CalcGlyphs.divide,
    CalcGlyphs.multiply,
    CalcGlyphs.minus,
    '+',
    '=',
  };

  @override
  Widget build(BuildContext context) {
    final bool isFunction = _isFunction;
    final bool isAccent = buttonColor != null;
    final Color background = buttonColor ??
        (isFunction ? AppPalettes.general.accent : ThemesMode.surface);
    final Color foreground = textColor ??
        (isFunction ? AppPalettes.general.onAccent : ThemesMode.onSurface);

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.allMd,
        border: isAccent || isFunction
            ? Border.all(color: background, width: AppBorders.hairline)
            : appBorder(),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadii.allMd,
          onTap: onPressed,
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: icon != null
                    ? Icon(icon, size: _fontSize, color: foreground)
                    : Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: FontWeight.w700,
                          color: foreground,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get _fontSize {
    if (title == CalcGlyphs.backspace || title == CalcGlyphs.more) {
      return responsiveText(19);
    }
    if (title == '00') return responsiveText(20);
    if (title.length > 1) return responsiveText(16);
    return responsiveText(22);
  }

  /// Accessible name for a key, used for the tooltip / semantics label.
  static String symbolName(String symbol) {
    if (symbol == CalcGlyphs.backspace) return 'Delete';
    if (symbol == CalcGlyphs.more) return 'More';
    if (symbol == '(') return 'Left bracket';
    if (symbol == ')') return 'Right bracket';
    if (symbol == 'C') return 'Clear';
    if (symbol == '%') return 'Percent';
    if (symbol == CalcGlyphs.powerOf) return 'Power of n';
    if (symbol == '.') return 'Decimal point';
    if (symbol == '=') return 'Equals';
    if (symbol == '+') return 'Addition';
    if (symbol == CalcGlyphs.minus) return 'Subtraction';
    if (symbol == CalcGlyphs.divide) return 'Division';
    if (symbol == CalcGlyphs.multiply) return 'Multiplication';
    return symbol;
  }
}
