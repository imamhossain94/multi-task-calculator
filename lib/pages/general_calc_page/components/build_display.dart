import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/themes_mode.dart';

/// The expression / result display for the general calculator.
///
/// Fills whatever height it is given and aligns its content to the bottom, so
/// the result sits on a stable baseline while the card grows and shrinks as
/// the scientific row toggles.
///
/// Both lines auto-fit rather than clip: the expression scrolls horizontally
/// and the result scales down to one line.
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
      margin: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
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
        // it instead left a void above a short result.
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
          Flexible(
            child: FittedBox(
              // `scaleDown` against a generous base size: the result fills
              // whatever height the card has, so it looks deliberate whether
              // the scientific row is open (short card) or closed (tall card).
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomRight,
              child: Text(
                result,
                maxLines: 1,
                textAlign: TextAlign.right,
                style: TextStyle(
                  // Idle state is deliberately larger - it is the first thing
                  // the eye lands on.
                  fontSize: idle ? 88 : 64,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  color: isError
                      ? AppColors.danger
                      : idle
                          ? ThemesMode.onSurface
                          : palette.accent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
