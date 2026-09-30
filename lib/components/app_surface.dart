import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/themes_mode.dart';

/// Shared visual primitives used by every screen.
///
/// The design language is flat and outlined:
///  * **No gradients.** Every accent is one solid colour.
///  * **No shadows.** Depth comes from a 1 px outline instead.
///  * **Small radii** (3-8 px) rather than the Material 3 pills.
///  * **Colour from the accent**, never from the background.
///
/// The building blocks are [AppPage] for the page shell, [AppCard] for
/// neutral surfaces, [AppAccentCard] for solid colour blocks, and the small
/// controls below.

/// Standard 1 px outline for the current theme.
Border appBorder({
  Color? color,
  double width = AppBorders.hairline,
}) =>
    Border.all(color: color ?? ThemesMode.border, width: width);

/// Neutral surface: a flat fill with a hairline outline. No shadow.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.margin = EdgeInsets.zero,
    this.radius = AppRadii.lg,
    this.color,
    this.borderColor,
    this.borderWidth = AppBorders.hairline,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double radius;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? ThemesMode.surface,
        borderRadius: BorderRadius.circular(radius),
        border: appBorder(color: borderColor, width: borderWidth),
      ),
      child: child,
    );
  }
}

/// A solid block of a tool's accent colour.
///
/// The replacement for the old gradient result tile: one flat fill, one flat
/// foreground, hairline outline of the same accent so the block keeps its edge
/// against a light background.
class AppAccentCard extends StatelessWidget {
  const AppAccentCard({
    super.key,
    required this.child,
    required this.palette,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin = EdgeInsets.zero,
    this.radius = AppRadii.lg,
    this.background,
  });

  final Widget child;
  final ToolPalette palette;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double radius;

  /// Override the solid fill, e.g. to render a muted variant.
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: background ?? palette.accent,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: palette.accent,
          width: AppBorders.hairline,
        ),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: palette.onAccent),
        child: child,
      ),
    );
  }
}

/// A thin solid accent bar, used to cap a card or mark a section.
class AppAccentStrip extends StatelessWidget {
  const AppAccentStrip({
    super.key,
    required this.palette,
    this.height = 3,
    this.radius = AppRadii.lg,
  });

  final ToolPalette palette;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: palette.accent,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
        ),
      ),
    );
  }
}

/// A small square/rounded tile filled with a tool's accent.
///
/// Used for the home-screen tile icons and the app-bar leading mark, so both
/// read as the same visual unit.
class AppAccentMark extends StatelessWidget {
  const AppAccentMark({
    super.key,
    required this.palette,
    required this.icon,
    this.size = 34,
    this.iconSize = 18,
    this.radius = AppRadii.md,
  });

  final ToolPalette palette;
  final IconData icon;
  final double size;
  final double iconSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: palette.accent,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(icon, size: iconSize, color: palette.onAccent),
    );
  }
}

/// Neutral surface that groups a calculator's input fields.
///
/// Owns the internal padding and the gap between fields, so every calculator
/// lines its inputs up identically.
class AppInputCard extends StatelessWidget {
  const AppInputCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: ThemesMode.surface,
        borderRadius: AppRadii.allLg,
        border: appBorder(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// App bar shared by every page: a flat accent tint with a hairline underline
/// instead of a translucent overlay.
class AppTitleBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTitleBar({
    super.key,
    required this.palette,
    required this.title,
    this.icon,
    this.actions = const <Widget>[],
    this.leading,
  });

  final ToolPalette palette;
  final String title;
  final IconData? icon;
  final List<Widget> actions;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: palette.soft(ThemesMode.isDarkMode, 0.07, 0.16),
      foregroundColor: ThemesMode.onSurface,
      surfaceTintColor: Colors.transparent,
      leading: leading,
      actions: actions,
      titleSpacing: icon == null ? null : 0,
      title: Row(
        children: <Widget>[
          if (icon != null) ...<Widget>[
            AppAccentMark(palette: palette, icon: icon!),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Audiowide',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: ThemesMode.onSurface,
              ),
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: ThemesMode.border),
      ),
    );
  }
}

/// Page shell for the informational screens (about, help, feedback, ...).
class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.palette,
    required this.title,
    required this.body,
    this.actions = const <Widget>[],
    this.leading,
    this.bottom,
    this.titleIcon,
    this.bottomBar,
  });

  final ToolPalette palette;
  final String title;
  final Widget body;
  final List<Widget> actions;
  final Widget? leading;
  final Widget? bottom;
  final IconData? titleIcon;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        palette: palette,
        title: title,
        icon: titleIcon,
        actions: actions,
        leading: leading,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: ThemesMode.background,
              child: SafeArea(top: false, bottom: false, child: body),
            ),
          ),
          if (bottom != null) bottom!,
          if (bottomBar != null) bottomBar!,
        ],
      ),
    );
  }
}

/// Flat chip: outlined when unselected, solid accent when selected.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.color,
    this.onTap,
    this.icon,
    this.selected = true,
    this.dense = false,
  });

  final String label;
  final Color? color;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool selected;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemesMode.isDarkMode;
    final Color accent = color ?? ThemesMode.onSurfaceMuted;
    final Color border = selected
        ? accent
        : (isDark ? AppColors.darkBorder : AppColors.lightBorder);
    final Color foreground = selected ? accent : ThemesMode.onSurfaceMuted;

    final Widget content = Container(
      height: dense ? 28 : 34,
      padding: EdgeInsets.symmetric(horizontal: dense ? AppSpacing.sm : 10),
      decoration: BoxDecoration(
        color: selected ? accent.withValues(alpha: isDark ? 0.18 : 0.10) : null,
        borderRadius: AppRadii.allSm,
        border: appBorder(
          color: border,
          width: selected ? AppBorders.strong : AppBorders.hairline,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: dense ? 13 : 15, color: foreground),
            const SizedBox(width: AppSpacing.xs + 2),
          ],
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontWeight: FontWeight.w700,
              fontSize: dense ? 12 : 13.5,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.allSm,
        onTap: onTap,
        child: content,
      ),
    );
  }
}

/// Two-to-three option segmented selector (gender, loan type, frequency).
///
/// Unselected segments are transparent with a hairline outline; the selected
/// one is a solid accent block. No shadow, no gradient.
class AppSegmented<T> extends StatelessWidget {
  const AppSegmented({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.palette,
    this.labelOf,
  });

  final String label;
  final List<T> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final ToolPalette palette;

  /// How to render an option. Defaults to `toString()`, which is wrong for
  /// enums - those render as `SomeEnum.value`.
  final String Function(T option)? labelOf;

  String _text(T option) => labelOf?.call(option) ?? option.toString();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm, left: 2),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
                color: ThemesMode.onSurfaceMuted,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: ThemesMode.surface,
            borderRadius: AppRadii.allMd,
            border: appBorder(),
          ),
          child: Row(
            children: options.map((T option) {
              final bool isSelected = option == selected;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOut,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? palette.accent : null,
                      borderRadius: AppRadii.allSm,
                      border: isSelected
                          ? null
                          : appBorder(
                              color: AppColors.lightBorder,
                            ),
                    ),
                    child: Text(
                      _text(option),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected
                            ? palette.onAccent
                            : ThemesMode.onSurfaceMuted,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(growable: false),
          ),
        ),
      ],
    );
  }
}

/// Primary action button: solid accent, no shadow.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.palette = AppPalettes.neutral,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final ToolPalette palette;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    final Color fill = enabled
        ? palette.accent
        : (ThemesMode.isDarkMode
            ? AppColors.darkSurfaceAlt
            : AppColors.lightSurfaceAlt);
    final Color foreground =
        enabled ? palette.onAccent : ThemesMode.onSurfaceMuted;

    final Widget content = Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: AppRadii.allMd,
        border: enabled
            ? Border.all(color: palette.accent, width: AppBorders.hairline)
            : appBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 17, color: foreground),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontWeight: FontWeight.w800,
                fontSize: 14.5,
              ),
            ),
          ),
        ],
      ),
    );

    final Widget wrapped = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.allMd,
        onTap: onPressed,
        child: content,
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: wrapped) : wrapped;
  }
}

/// Secondary action button: transparent fill, 1.5 px accent outline.
class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.palette = AppPalettes.neutral,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final ToolPalette palette;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    final Color foreground =
        enabled ? palette.accent : ThemesMode.onSurfaceMuted;

    final Widget content = Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppRadii.allMd,
        border: Border.all(
          color: enabled ? palette.accent : ThemesMode.border,
          width: AppBorders.strong,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 16, color: foreground),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontWeight: FontWeight.w800,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );

    final Widget wrapped = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.allMd,
        onTap: onPressed,
        child: content,
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: wrapped) : wrapped;
  }
}
