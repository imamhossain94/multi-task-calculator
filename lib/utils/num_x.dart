import 'dart:math' as math;

/// Safe numeric helpers shared by every calculator.
///
/// The original implementation divided raw user input straight into its
/// formula, which meant an empty or zero field produced `Infinity` / `NaN` and
/// those values leaked into the UI. Everything here returns a safe fallback
/// instead.
abstract final class NumX {
  NumX._();

  /// [value] if it is a finite number, otherwise [fallback] (default `0`).
  static double sanitize(double value, [double fallback = 0]) =>
      value.isFinite ? value : fallback;

  /// Division that never returns `Infinity`/`NaN`.
  ///
  /// Returns [fallback] (default `0`) when [divisor] is zero or either operand
  /// is not finite.
  static double divide(num a, num b, [double fallback = 0]) {
    if (b == 0) return fallback;
    return sanitize(a / b, fallback);
  }

  /// Safe percentage: `part / whole * 100`, guarding a zero `whole`.
  static double percent(num part, num whole, [double fallback = 0]) =>
      divide(part * 100, whole, fallback);

  /// Clamp helper that is tolerant of reversed bounds.
  static double clampNum(num value, num min, num max) {
    final double lo = math.min(min, max).toDouble();
    final double hi = math.max(min, max).toDouble();
    return value.toDouble().clamp(lo, hi);
  }

  /// Fixed-precision string with thousands separators, safe for any input.
  ///
  /// Non-finite results render as [fallback] (`0.00` by default) so the UI can
  /// never show `NaN` or `Infinity`.
  static String format(num? value,
      {int decimals = 2, String fallback = '0.00'}) {
    if (value == null) return fallback;
    final double v = value.toDouble();
    if (!v.isFinite) return fallback;
    final String fixed = v.toStringAsFixed(decimals);
    final bool negative = fixed.startsWith('-');
    final String digits = negative ? fixed.substring(1) : fixed;
    final List<String> parts = digits.split('.');
    final String grouped = _group(parts.first);
    final String out = parts.length > 1 ? '$grouped.${parts[1]}' : grouped;
    return negative ? '-$out' : out;
  }

  static String _group(String digits) {
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  /// Currency string, e.g. `$1,234.50`.
  static String money(num? value, {String symbol = r'$', int decimals = 2}) =>
      '$symbol${format(value, decimals: decimals)}';

  /// Percent string, e.g. `12.50%`.
  static String percentText(num? value, {int decimals = 2}) =>
      '${format(value, decimals: decimals)}%';
}
