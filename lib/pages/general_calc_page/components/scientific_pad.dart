import 'package:flutter/material.dart';

import '../../../utils/screen_config.dart';
import 'build_calc_pad.dart' show CalcGlyphs;
import '../../../utils/themes_mode.dart';
import '../../../utils/app_color.dart';

/// Scientific function labels, written as escapes so they cannot be corrupted
/// by an editor or shell that mis-guesses the file encoding.
abstract final class SciGlyphs {
  static const String sqrt = '\u221A'; // √
  static const String squared = 'x\u00B2'; // x²
  static const String cubed = 'x\u00B3'; // x³
  static const String plusMinus = '\u00B1'; // ±
  static const String pi = '\u03C0'; // π
  static const String more = CalcGlyphs.more;

  static const List<String> values = <String>[
    sqrt,
    squared,
    cubed,
    plusMinus,
    pi,
  ];
}

/// Collapsible row of scientific functions, toggled by the `⋯` key.
///
/// The `⋯` button previously called an empty `showMoreMenu()` stub, so the
/// function was advertised in the tooltip but did nothing.
class ScientificPad extends StatelessWidget {
  const ScientificPad({
    super.key,
    required this.onPressed,
    required this.palette,
    this.expanded = true,
    this.toggleKey,
  });

  final ValueChanged<String> onPressed;
  final ToolPalette palette;

  /// Whether the function grid is currently visible.
  final bool expanded;

  /// Emits `'⋯'` when the expand/collapse chip is tapped.
  final ValueChanged<String>? toggleKey;

  /// Label -> math function applied to the trailing operand.
  static const List<(String, String)> functions = <(String, String)>[
    ('sin', 'sin'),
    ('cos', 'cos'),
    ('tan', 'tan'),
    ('ln', 'ln'),
    ('log', 'log'),
    (SciGlyphs.sqrt, '√'),
    (SciGlyphs.squared, 'x²'),
    (SciGlyphs.cubed, 'x³'),
    ('1/x', '1/x'),
    ('x!', 'x!'),
    (SciGlyphs.plusMinus, '±'),
    (SciGlyphs.pi, 'pi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.page, AppSpacing.xs, AppSpacing.page, AppSpacing.xs),
          child: Row(
            children: <Widget>[
              Text(
                'SCIENTIFIC',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: ThemesMode.onSurfaceMuted,
                ),
              ),
              const Spacer(),
              if (toggleKey != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: AppRadii.allXs,
                    onTap: () => toggleKey!(SciGlyphs.more),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs + 2, vertical: 2),
                      child: Row(
                        children: <Widget>[
                          Text(
                            expanded ? 'Hide' : 'Show',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                              color: palette.accent,
                            ),
                          ),
                          Icon(
                            expanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 16,
                            color: palette.accent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 160),
          crossFadeState:
              expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, 2, AppSpacing.md, AppSpacing.sm),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 6,
              mainAxisSpacing: AppSpacing.xs + 1,
              crossAxisSpacing: AppSpacing.xs + 1,
              childAspectRatio: 1.85,
              children: functions.map(((String, String) entry) {
                final (String label, String fn) = entry;
                return _FunctionChip(
                  label: label,
                  color: palette.accent,
                  onTap: () => onPressed(fn),
                );
              }).toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}

class _FunctionChip extends StatelessWidget {
  const _FunctionChip({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.allSm,
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: AppRadii.allSm,
            border: Border.all(
              color: color.withValues(alpha: 0.34),
              width: AppBorders.hairline,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: responsiveText(14),
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
