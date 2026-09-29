// Tests for `NumX` â€” the guard layer that stops `Infinity` / `NaN` from
// reaching the UI, and the thousands-separator formatter.

import 'package:flutter_test/flutter_test.dart';
import 'package:multi_task_calculator/utils/num_x.dart';

void main() {
  group('divide', () {
    test('normal division', () {
      expect(NumX.divide(10, 4), 2.5);
    });

    test('zero divisor returns the fallback, not Infinity', () {
      expect(NumX.divide(10, 0), 0);
      expect(NumX.divide(10, 0, 99), 99);
    });

    test('a non-finite numerator is sanitised', () {
      expect(NumX.divide(double.infinity, 2), 0);
      expect(NumX.divide(double.nan, 2), 0);
    });
  });

  group('percent', () {
    test('part of whole', () {
      expect(NumX.percent(25, 200), 12.5);
    });

    test('zero whole returns 0', () {
      expect(NumX.percent(25, 0), 0);
    });
  });

  test('sanitize keeps finite values and replaces the rest', () {
    expect(NumX.sanitize(3.5), 3.5);
    expect(NumX.sanitize(double.infinity), 0);
    expect(NumX.sanitize(double.nan, -1), -1);
  });

  test('clampNum tolerates reversed bounds', () {
    expect(NumX.clampNum(15, 0, 10), 10);
    expect(NumX.clampNum(15, 10, 0), 10);
    expect(NumX.clampNum(5, 0, 10), 5);
  });

  group('format', () {
    test('adds thousands separators', () {
      expect(NumX.format(1234567.891), '1,234,567.89');
      expect(NumX.format(1000), '1,000.00');
      expect(NumX.format(999), '999.00');
    });

    test('handles negatives', () {
      expect(NumX.format(-1234.5), '-1,234.50');
    });

    test('renders non-finite values as the fallback', () {
      expect(NumX.format(double.infinity), '0.00');
      expect(NumX.format(double.nan), '0.00');
      expect(NumX.format(double.infinity, fallback: 'â€”'), 'â€”');
    });

    test('handles null', () {
      expect(NumX.format(null), '0.00');
    });

    test('honours the decimals argument', () {
      expect(NumX.format(1.23456, decimals: 3), '1.235');
      expect(NumX.format(1.23456, decimals: 0), '1');
    });
  });

  test('money and percentText', () {
    expect(NumX.money(1234.5), r'$1,234.50');
    expect(NumX.percentText(12.3456), '12.35%');
  });
}
