import 'package:flutter/material.dart';

import 'build_calc_pad.dart';

/// The general calculator's body.
///
/// The three regions are laid out as one column of fixed-height bands:
///
/// ```text
/// ┌─────────────────────────────┐  gutter
/// │        display              │  takes every pixel left over
/// ├─────────────────────────────┤
/// │ SCIENTIFIC           Hide ⌃ │  fixed
/// │ [sin][cos][tan][ln][..][√]  │  fixed
/// │ [x²][x³][1/x][x!][±][π]     │  fixed
/// ├─────────────────────────────┤
/// │ [⋯][(][)][⌫]               │  fixed: 4:3 keys, width-derived
/// │ [C][%][xⁿ][÷]               │
/// │ …                           │
/// └─────────────────────────────┘
/// ```
///
/// The pad's height depends only on the available **width**, which does not
/// change when the scientific row toggles. So the display absorbs the change:
/// showing the row shrinks the display, hiding it grows the display, and the
/// keys never move.
///
/// Every band spans the same horizontal gutter, so the display card, the
/// scientific chips and the outermost keys all line up on both edges.
class GeneralCalcBody extends StatelessWidget {
  const GeneralCalcBody({
    super.key,
    required this.display,
    required this.scientific,
    required this.onKey,
  });

  /// The readout. Sits in an [Expanded] and absorbs all remaining height.
  final Widget display;

  /// The collapsible scientific strip. Renders its own header and rows.
  final Widget scientific;

  final ValueChanged<String> onKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: display),
        scientific,
        BuildCalcPad(onPressed: onKey),
      ],
    );
  }
}
