import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/num_x.dart';
import '../utils/screen_config.dart';
/// A single result tile, filled with the tool's gradient.
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
    final String text = numeric != null
        ? NumX.format(numeric, decimals: decimals)
        : value;

    final Widget tile = Container(
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 14),
      decoration: BoxDecoration(
        gradient: palette.diagonal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette.accent.withValues(alpha: 0.34),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 22, color: Colors.white.withValues(alpha: 0.9)),
            const SizedBox(height: 8),
          ],
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$prefix$text$suffix',
              maxLines: 1,
              style: TextStyle(
                fontSize: responsiveText(24),
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: const <Shadow>[
                  Shadow(color: Color(0x33000000), blurRadius: 6),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 1.5,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );

    return group ? Expanded(child: tile) : tile;
  }
}
