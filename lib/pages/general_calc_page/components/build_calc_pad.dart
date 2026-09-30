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
/// Every key is the same size: the pad derives one square key dimension from
/// the smaller of the available width and height, so the six rows are always
/// evenly proportioned and no key is taller or wider than its neighbours. The
/// gap is part of the key's footprint, which keeps the rhythm identical
/// horizontally and vertically.
///
/// A [Table] would have been the obvious choice, but it sizes rows to their
/// content and overflowed on shorter screens.
class BuildCalcPad extends StatelessWidget {
  const BuildCalcPad({super.key, required this.onPressed});

  final ValueChanged<String> onPressed;

  static const int columns = 4;

  /// Gap between keys, applied on all four sides so the outer margins match
  /// the inner ones.
  static const double _gap = 5;

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
    final int rows = _rows.length;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // One key edge, derived from both axes so the grid stays square.
        final double byWidth =
            (constraints.maxWidth - _gap * (columns + 1)) / columns;
        final double byHeight =
            (constraints.maxHeight - _gap * (rows + 1)) / rows;
        final double size = byWidth < byHeight ? byWidth : byHeight;

        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: size * columns + _gap * (columns + 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final List<String> row in _rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: _gap),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (int i = 0; i < columns; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: _gap),
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: _key(
                                i < row.length ? row[i] : '',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
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
