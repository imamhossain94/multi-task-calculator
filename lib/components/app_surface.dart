import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/screen_config.dart';
import '../utils/themes_mode.dart';
/// Shared visual primitives used by every screen.
///
/// The goal is a consistent, colourful look with a very small number of
/// building blocks: [AppPage] for the gradient background, [AppCard] for
/// neutral surfaces and [AppGradientCard] for the accent-heavy result tiles.

/// Soft drop shadow used by every raised surface.
List<BoxShadow> appShadow({double elevation = 6, Color? tint}) {
  final Color color = tint ??
      (ThemesMode.isDarkMode ? Colors.black38 : Colors.black.withValues(alpha: 0.07));
  return <BoxShadow>[
    BoxShadow(
      color: color,
      blurRadius: elevation * 2.4,
      spreadRadius: elevation * 0.2,
      offset: Offset(0, elevation * 0.6),
    ),
  ];
}

/// Standard rounded surface.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin = EdgeInsets.zero,
    this.radius = 20,
    this.color,
    this.gradient,
    this.elevation = 6,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double radius;
  final Color? color;
  final Gradient? gradient;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? ThemesMode.surface) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: appShadow(elevation: elevation),
      ),
      child: child,
    );
  }
}

/// Surface filled with a tool's gradient. Used for headers and result tiles.
class AppGradientCard extends StatelessWidget {
  const AppGradientCard({
    super.key,
    required this.child,
    required this.palette,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.radius = 20,
    this.diagonal = true,
    this.elevation = 8,
  });

  final Widget child;
  final ToolPalette palette;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double radius;
  final bool diagonal;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: diagonal ? palette.diagonal : palette.linear,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette.accent.withValues(alpha: 0.32),
            blurRadius: elevation * 2.6,
            spreadRadius: elevation * 0.15,
            offset: Offset(0, elevation * 0.7),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// A coloured strip that visually connects a header to its card.
class AppAccentStrip extends StatelessWidget {
  const AppAccentStrip({super.key, required this.palette, this.height = 5});

  final ToolPalette palette;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: palette.linear,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}

/// Page scaffold with the app's gradient background.
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

  /// Optional panel rendered directly under the app bar.
  final Widget? bottom;

  final IconData? titleIcon;

  /// Pinned widget (typically the banner ad) at the bottom of the page.
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: leading,
        actions: actions,
        titleSpacing: titleIcon == null ? null : 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (titleIcon != null) ...<Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: palette.linear,
                  shape: BoxShape.circle,
                ),
                child: Icon(titleIcon, size: 19, color: Colors.white),
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: responsiveText(19),
                  fontWeight: FontWeight.w700,
                  color: ThemesMode.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    palette.accent.withValues(alpha: 0.10),
                    ThemesMode.background,
                    ThemesMode.background,
                  ],
                  stops: const <double>[0, 0.22, 1],
                ),
              ),
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

/// Small pill used for units, currencies and toggles.
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
    final Color accent = color ?? ThemesMode.onSurfaceMuted;
    final Color fg = selected ? Colors.white : ThemesMode.onSurfaceMuted;

    final Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      height: dense ? 32 : 40,
      padding: EdgeInsets.symmetric(horizontal: dense ? 10 : 14),
      decoration: BoxDecoration(
        gradient: selected ? accent.asLinearGradient() : null,
        color: selected ? null : ThemesMode.subtleFill,
        borderRadius: BorderRadius.circular(dense ? 10 : 12),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: dense ? 14 : 18, color: fg),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: dense ? 12 : 14,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(dense ? 10 : 12),
        onTap: onTap,
        child: content,
      ),
    );
  }
}

/// Two-to-three option segmented selector (gender, loan type, frequency).
class AppSegmented<T> extends StatelessWidget {
  const AppSegmented({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.palette,
  });

  final String label;
  final List<T> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final ToolPalette palette;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 2),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
              color: ThemesMode.onSurface,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ThemesMode.subtleFill,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: options.map((T option) {
              final bool isSelected = option == selected;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: isSelected ? palette.linear : null,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: isSelected
                          ? <BoxShadow>[
                              BoxShadow(
                                color: palette.accent.withValues(alpha: 0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      option.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? Colors.white : ThemesMode.onSurfaceMuted,
                        fontWeight: FontWeight.w800,
                        fontSize: 13.5,
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

/// Filled primary button with a gradient.
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
    final Widget content = Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: enabled ? palette.linear : null,
        color: enabled ? null : ThemesMode.subtleFill,
        borderRadius: BorderRadius.circular(14),
        boxShadow: enabled
            ? <BoxShadow>[
                BoxShadow(
                  color: palette.accent.withValues(alpha: 0.32),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 18, color: enabled ? Colors.white : ThemesMode.onSurfaceMuted),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: enabled ? Colors.white : ThemesMode.onSurfaceMuted,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );

    return expand
        ? SizedBox(width: double.infinity, child: _wrap(content, enabled))
        : _wrap(content, enabled);
  }

  Widget _wrap(Widget child, bool enabled) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: child,
        ),
      );
}

/// Small helper so widgets can accept either a flat colour or a gradient.
extension GradientFromColor on Color {
  LinearGradient asLinearGradient() =>
      LinearGradient(colors: <Color>[this, this]);
}
