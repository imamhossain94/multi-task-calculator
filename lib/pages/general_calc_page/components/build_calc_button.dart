import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/screen_config.dart';
/// A single key on the general calculator pad.
class BuildCalcButton extends StatelessWidget {
  const BuildCalcButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  final String title;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isFunction = _functionKeys.contains(title);
    final Color background =
        buttonColor ?? (isFunction ? AppColors.brand : Colors.transparent);
    final Color foreground = textColor ??
        (isFunction
            ? Colors.white
            : const Color(0xFF2A2E52));

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: buttonColor == null
            ? null
            : <BoxShadow>[
                BoxShadow(
                  color: background.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            height: 52,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.w800,
                color: foreground,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get _fontSize {
    if (title == 'âŒ«' || title == 'â‹¯') return responsiveText(20);
    if (title == '00') return responsiveText(21);
    if (title.length > 1) return responsiveText(17);
    return responsiveText(24);
  }

  /// Keys rendered in the brand colour (operators, brackets, clear).
  static const Set<String> _functionKeys = <String>{
    'â‹¯', '(', ')', 'âŒ«', 'C', '%', 'xâ¿', 'Ã·', 'Ã—', 'â€“', '+', '=',
  };

  /// Accessible name for a key, used for the tooltip / semantics label.
  static String symbolName(String symbol) {
    switch (symbol) {
      case 'âŒ«':
        return 'Delete';
      case 'â‹¯':
        return 'More';
      case '(':
        return 'Left bracket';
      case ')':
        return 'Right bracket';
      case 'C':
        return 'Clear';
      case '%':
        return 'Percent';
      case 'xâ¿':
        return 'Power of n';
      case '.':
        return 'Decimal point';
      case '=':
        return 'Equals';
      case '+':
        return 'Addition';
      case 'â€“':
        return 'Subtraction';
      case 'Ã·':
        return 'Division';
      case 'Ã—':
        return 'Multiplication';
      default:
        return symbol;
    }
  }
}
