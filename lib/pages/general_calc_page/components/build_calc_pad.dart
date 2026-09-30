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
/// Every key is the same size and has a fixed **4:3** shape, derived from the
/// available width alone. Because the width does not change when the scientific
/// row is toggled, neither does the pad - the display above it absorbs the
/// difference, so the keys never jump.
///
/// The gap is the same on all four sides, so the outer margin between the
/// outermost keys and the page gutter matches the gap between keys.
class BuildCalcPad extends StatelessWidget {
  const BuildCalcPad({super.key, required this.onPressed});

  final ValueChanged<String> onPressed;

  static const int columns = 4;
  static const int rowCount = 6;

  /// Key width : key height.
  static const double aspect = 4 / 3;

  /// Gap between keys, and between the outer keys and the page gutter.
  static const double gap = 5;

  static const List<List<String>> _rows = <List<String>>[
    <String>[CalcGlyphs.more, '(', ')', CalcGlyphs.backspace],
    <String>['C', '%', CalcGlyphs.powerOf, CalcGlyphs.divide],
    <String>['7', '8', '9', CalcGlyphs.multiply],
    <String>['4', '5', '6', CalcGlyphs.minus],
    <String>['1', '2', '3', '+'],
    <String>['0', '00', '.', '='],
  ];

  /// Total height the pad occupies for a given available width.
  static double heightFor(double width) {
    final double key = (width - gap * (columns + 1)) / columns;
    return key / aspect + gap * (rowCount + 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double key =
            (constraints.maxWidth - gap * (columns + 1)) / columns;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final List<String> row in _rows)
              Padding(
                padding: const EdgeInsets.only(bottom: gap),
                child: Row(
                  // A gap *before every key and one after the last*, which is
                  // `columns + 1` of them - the same count `key` is sized
                  // against. Emitting only the internal gaps leaves the row
                  // `2 * gap` short of the available width, so the right edge
                  // stops short of the display card's.
                  children: <Widget>[
                    for (int i = 0; i < columns; i++) ...<Widget>[
                      const SizedBox(width: gap),
                      SizedBox(
                        width: key,
                        height: key / aspect,
                        child: _key(i < row.length ? row[i] : ''),
                      ),
                    ],
                    const SizedBox(width: gap),
                  ],
                ),
              ),
            // Trailing gap, so the bottom margin matches the side margins.
            const SizedBox(height: gap),
          ],
        );
      },
    );
  }

  Widget _key(String key) => BuildCalcButton(
        title: key,
        icon: _iconFor(key),
        buttonColor: key == '=' ? AppPalettes.general.accent : null,
        textColor: key == '=' ? Colors.white : null,
        onPressed: () => onPressed(key),
      );

  /// Icons for the two keys whose glyphs Audiowide cannot draw.
  static IconData? _iconFor(String key) => switch (key) {
        CalcGlyphs.more => Icons.more_horiz_rounded,
        CalcGlyphs.backspace => Icons.backspace_outlined,
        _ => null,
      };
}
