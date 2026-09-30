import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/themes_mode.dart';

/// The expression / result display for the general calculator.
///
/// A single flat panel that owns a fixed share of the screen, so the result
/// always has room and the key pad below it always gets a square grid.
///
/// Both lines auto-shrink rather than clip: a long expression scrolls
/// horizontally and the result shrinks to fit its one line.
class BuildDisplay extends StatelessWidget {
  const BuildDisplay({
    super.key,
    required this.expression,
    required this.preview,
    this.error,
    required this.palette,
  });

  /// What the user has typed. Empty until the first key press.
  final String expression;

  /// The committed or live result. Empty means "nothing to show yet".
  final String preview;

  final String? error;
  final ToolPalette palette;

  @override
  Widget build(BuildContext context) {
    final String? message = error;
    final bool typed = expression.isNotEmpty;
    final String result = message ?? (preview.isEmpty ? '0' : preview);
    final bool isError = message != null;
    final bool idle = !typed && preview.isEmpty && !isError;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: ThemesMode.surface,
        borderRadius: AppRadii.allLg,
        border: Border.all(
          color: isError ? AppColors.danger : ThemesMode.border,
          width: isError ? AppBorders.strong : AppBorders.hairline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // The result hugs the bottom edge and the expression sits directly
        // above it, so the block grows upward from a fixed baseline. Centring
        // it instead left a large void on an idle calculator.
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // The typed expression sits above the result in the muted colour, so
          // the result is always the most prominent thing on the screen.
          if (typed)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 30),
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  expression,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: ThemesMode.onSurfaceMuted,
                  ),
                ),
              ),
            ),
          if (typed) const SizedBox(height: AppSpacing.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              result,
              maxLines: 1,
              textAlign: TextAlign.right,
              style: TextStyle(
                // Idle state is deliberately larger - it is the first thing
                // the eye lands on.
                fontSize: idle ? 52 : 40,
                fontWeight: FontWeight.w800,
                height: 1.15,
                color: isError
                    ? AppColors.danger
                    : idle
                        ? ThemesMode.onSurface
                        : palette.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
