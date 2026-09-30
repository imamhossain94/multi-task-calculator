import 'package:flutter/material.dart';

import '../utils/num_x.dart';
import '../utils/screen_config.dart';
import '../utils/app_color.dart';

/// A single result tile: one flat block of the tool's accent colour.
///
/// Values are rendered through [NumX.format], so a degenerate calculation
/// (empty field, division by zero) shows `0.00` instead of the `Infinity` the
/// old implementation produced.
class BuildResultCard extends StatelessWidget {
  const BuildResultCard({
    super.key,
    required this.title,
    this.value = '',
    this.numeric,
    this.palette = AppPalettes.neutral,
    this.prefix = '',
    this.suffix = '',
    this.decimals = 2,
    this.icon,
    this.group = true,
  });

  /// Raw display string. Ignored when [numeric] is supplied.
  final String value;

  /// When set, the value is formatted with thousands separators instead of
  /// using [value] verbatim.
  final num? numeric;

  final String title;
  final ToolPalette palette;
  final String prefix;
  final String suffix;
  final int decimals;
  final IconData? icon;

  /// Wrap this tile in an `Expanded` so a row of tiles shares the width evenly.
  final bool group;

  @override
  Widget build(BuildContext context) {
    final String text =
        numeric != null ? NumX.format(numeric, decimals: decimals) : value;

    final Color onAccent = palette.onAccent;

    final Widget tile = Container(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.md - 2),
      decoration: BoxDecoration(
        color: palette.accent,
        borderRadius: AppRadii.allLg,
        border: Border.all(color: palette.accent, width: AppBorders.hairline),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 20, color: onAccent.withValues(alpha: 0.85)),
            const SizedBox(height: 6),
          ],
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$prefix$text$suffix',
              maxLines: 1,
              style: TextStyle(
                fontSize: responsiveText(23),
                fontWeight: FontWeight.w900,
                color: onAccent,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 1,
            width: 26,
            color: onAccent.withValues(alpha: 0.40),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: onAccent.withValues(alpha: 0.88),
            ),
          ),
        ],
      ),
    );

    // A fixed gutter so every row of result tiles has the same rhythm, whether
    // it holds two tiles or four.
    return group
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: tile,
            ),
          )
        : tile;
  }
}
