import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import 'build_calc_button.dart';

/// The glyphs on the pad, written as escapes so they can never be corrupted by
/// an editor or shell that mis-guesses the file encoding.
abstract final class CalcGlyphs {
  /// U+22EF MIDLINE HORIZONTAL ELLIPSIS - the "more" key.
  static const String more = '\u22EF';

  /// U+232B ERASE TO THE LEFT - the backspace key.
  static const String backspace = '\u232B';

  /// U+00D7 MULTIPLICATION SIGN.
  static const String multiply = '\u00D7';

  /// U+00F7 DIVISION SIGN.
  static const String divide = '\u00F7';

  /// U+2212 MINUS SIGN.
  static const String minus = '\u2212';

  /// U+207F SUPERSCRIPT LATIN SMALL LETTER N - "power of".
  static const String powerOf = 'x\u207F';

  static const List<String> values = <String>[
    more,
    backspace,
    multiply,
    divide,
    minus,
    powerOf,
  ];
}

/// Numeric / operator pad for the general calculator.
///
/// Built from nested `Expanded`s rather than a [Table] so the six rows always
/// share exactly the height that is left over. A `Table` sizes its rows to
/// their content, which overflowed on shorter screens.
class BuildCalcPad extends StatelessWidget {
  const BuildCalcPad({super.key, required this.onPressed});

  final ValueChanged<String> onPressed;

  static const List<List<String>> _rows = <List<String>>[
    <String>[CalcGlyphs.more, '(', ')', CalcGlyphs.backspace],
    <String>['C', '%', CalcGlyphs.powerOf, CalcGlyphs.divide],
    <String>['7', '8', '9', CalcGlyphs.multiply],
    <String>['4', '5', '6', CalcGlyphs.minus],
    <String>['1', '2', '3', '+'],
    <String>['0', '00', '.', '='],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        0,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Column(
        children: <Widget>[
          for (final List<String> row in _rows)
            Expanded(
              child: Row(
                children: <Widget>[
                  for (final String key in row) Expanded(child: _key(key)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _key(String key) => Padding(
        padding: const EdgeInsets.all(3),
        child: BuildCalcButton(
          title: key,
          icon: _iconFor(key),
          buttonColor: key == '=' ? AppPalettes.general.accent : null,
          textColor: key == '=' ? Colors.white : null,
          onPressed: () => onPressed(key),
        ),
      );

  /// Icons for the two keys whose glyphs Audiowide cannot draw.
  static IconData? _iconFor(String key) => switch (key) {
        CalcGlyphs.more => Icons.more_horiz_rounded,
        CalcGlyphs.backspace => Icons.backspace_outlined,
        _ => null,
      };
}
