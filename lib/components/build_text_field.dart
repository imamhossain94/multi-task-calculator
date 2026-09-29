import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/screen_config.dart';
import '../utils/themes_mode.dart';
/// Labelled numeric input with a unit / action chip on the right.
///
/// The unit chip is tappable ([onPressedAction]) which is how the tip and
/// savings screens switch between `$` and `%`.
class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.title,
    required this.hint,
    required this.widget,
    required this.textController,
    required this.onPressedAction,
    required this.isEnabled,
    this.palette = AppPalettes.neutral,
  });

  final String title;
  final String hint;

  /// The trailing unit chip: a `Text`, an `Icon`, or anything else.
  final Widget widget;

  final TextEditingController textController;
  final VoidCallback? onPressedAction;
  final bool isEnabled;
  final ToolPalette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
              color: isEnabled
                  ? ThemesMode.onSurface
                  : ThemesMode.onSurfaceMuted,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: ThemesMode.subtleFill,
                    borderRadius: BorderRadius.circular(14),
                    border: isEnabled
                        ? null
                        : Border.all(
                            color: ThemesMode.onSurfaceMuted.withValues(alpha: 0.2),
                          ),
                  ),
                  child: TextField(
                    controller: textController,
                    enabled: isEnabled,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: responsiveText(17),
                      color: isEnabled ? ThemesMode.onSurface : ThemesMode.onSurfaceMuted,
                    ),
                    decoration: InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: ThemesMode.onSurfaceMuted.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _UnitChip(
                palette: palette,
                onTap: onPressedAction,
                child: widget,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UnitChip extends StatelessWidget {
  const _UnitChip({required this.child, required this.palette, this.onTap});

  final Widget child;
  final ToolPalette palette;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 48,
          constraints: const BoxConstraints(minWidth: 58),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: onTap == null ? null : palette.linear,
            color: onTap == null ? palette.accent.withValues(alpha: 0.14) : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: onTap == null ? palette.accent : Colors.white,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
