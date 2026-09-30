import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/screen_config.dart';
import '../utils/themes_mode.dart';

/// Labelled numeric input with a unit / action chip on the right.
///
/// Flat design: the field is a plain surface with a hairline outline that
/// thickens to the tool's accent while focused. The unit chip is outlined
/// when it is a static label and solid accent when it is tappable
/// ([onPressedAction]), which is how the tip and savings screens switch
/// between `$` and `%`.
class BuildTextField extends StatefulWidget {
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
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  /// Only used to read focus state; the field itself is still the focus owner.
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocus);
  }

  @override
  void dispose() {
    _focus
      ..removeListener(_onFocus)
      ..dispose();
    super.dispose();
  }

  void _onFocus() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.isEnabled;
    final bool focused = _focus.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            color:
                ThemesMode.onSurfaceMuted.withValues(alpha: enabled ? 1 : 0.6),
          ),
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: ThemesMode.subtleFill,
                  borderRadius: AppRadii.allMd,
                  border: Border.all(
                    color: !enabled
                        ? ThemesMode.border
                        : focused
                            ? widget.palette.accent
                            : ThemesMode.border,
                    width: focused ? AppBorders.strong : AppBorders.hairline,
                  ),
                ),
                child: TextField(
                  controller: widget.textController,
                  focusNode: _focus,
                  enabled: enabled,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: responsiveText(16),
                    color: enabled
                        ? ThemesMode.onSurface
                        : ThemesMode.onSurfaceMuted,
                  ),
                  decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: ThemesMode.onSurfaceMuted.withValues(alpha: 0.55),
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
            const SizedBox(width: AppSpacing.sm),
            _UnitChip(
              palette: widget.palette,
              onTap: widget.onPressedAction,
              child: widget.widget,
            ),
          ],
        ),
      ],
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
    final bool tappable = onTap != null;
    final Color foreground = tappable ? palette.onAccent : palette.accent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.allMd,
        onTap: onTap,
        child: Container(
          height: 46,
          constraints: const BoxConstraints(minWidth: 52),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tappable ? palette.accent : null,
            borderRadius: AppRadii.allMd,
            border: Border.all(
              color: tappable ? palette.accent : palette.accent,
              width: tappable ? AppBorders.strong : AppBorders.hairline,
            ),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: foreground,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
