// Guards the characters the calculator depends on.
//
// Two things have gone wrong here before, and both are invisible in a normal
// code review:
//
//  1. A file round-tripped through a mis-guessed encoding turned U+22EF into
//     three characters, so the "more" key stopped matching `_moreKey`.
//  2. Audiowide has no glyph for U+22EF, U+232B, U+207F, U+221A or U+03C0, so
//     those keys rendered blank until the theme gained a font fallback.
//
// `CalcGlyphs` writes its values as \u escapes so (1) cannot recur; this test
// pins the exact code points so a careless edit is caught immediately.

import 'package:flutter_test/flutter_test.dart';
import 'package:multi_task_calculator/pages/general_calc_page/components/build_calc_pad.dart';
import 'package:multi_task_calculator/pages/general_calc_page/components/scientific_pad.dart';
import 'package:multi_task_calculator/utils/constant.dart';

void main() {
  test('key pad glyphs are the intended code points', () {
    expect(CalcGlyphs.more, '⋯');
    expect(CalcGlyphs.backspace, '⌫');
    expect(CalcGlyphs.multiply, '×');
    expect(CalcGlyphs.divide, '÷');
    expect(CalcGlyphs.minus, '−');
    expect(CalcGlyphs.powerOf, 'xⁿ');
  });

  test('scientific glyphs are the intended code points', () {
    expect(SciGlyphs.sqrt, '√');
    expect(SciGlyphs.squared, 'x²');
    expect(SciGlyphs.cubed, 'x³');
    expect(SciGlyphs.plusMinus, '±');
    expect(SciGlyphs.pi, 'π');
  });

  test('no glyph string is accidentally multi-byte mojibake', () {
    for (final String glyph in <String>[
      ...CalcGlyphs.values,
      ...SciGlyphs.values,
    ]) {
      expect(glyph.runes.length, lessThanOrEqualTo(2), reason: glyph);
    }
  });

  test('a symbol fallback font is declared for the glyphs Audiowide lacks', () {
    // U+22EF, U+232B, U+207F, U+221A and U+03C0 are absent from Audiowide.
    expect(fontSymbolFallback, isNotEmpty);
    expect(fontSymbolFallback, isNot(fontAudioWide));
  });
}
