import 'package:flutter/material.dart';

import 'app_surface.dart';
import '../utils/app_color.dart';
import '../utils/themes_mode.dart';

/// Base layout for the "form + results" calculators.
///
/// Subclasses provide a palette, title and icon; this widget handles the flat
/// app bar, the page background, the scrollable body and the pinned footer, so
/// every calculator page looks and behaves the same.
class CalculatorScaffold extends StatelessWidget {
  const CalculatorScaffold({
    super.key,
    required this.palette,
    required this.title,
    required this.icon,
    required this.children,
    this.actions = const <Widget>[],
    this.controller,
    this.padding = const EdgeInsets.fromLTRB(
        AppSpacing.page, AppSpacing.md, AppSpacing.page, AppSpacing.page),
    this.fillHeight = false,
  });

  final ToolPalette palette;
  final String title;
  final IconData icon;

  /// The calculator's input cards and result tiles.
  final List<Widget> children;

  final List<Widget> actions;
  final ScrollController? controller;
  final EdgeInsetsGeometry padding;

  /// Lay the children out in a [Column] that fills the screen instead of
  /// scrolling.
  ///
  /// Required for screens whose body contains a `Flex` child (the general
  /// calculator's key pad uses `Expanded`). A `SingleChildScrollView` is not a
  /// [Flex], so an `Expanded` inside it throws a layout error and the page
  /// renders blank.
  final bool fillHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        palette: palette,
        title: title,
        icon: icon,
        actions: actions,
      ),
      body: Container(
        color: ThemesMode.background,
        child: SafeArea(
          top: false,
          child: fillHeight
              ? Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                )
              : SingleChildScrollView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
        ),
      ),
    );
  }
}

/// Reset button shared by every calculator's app bar.
class CalculatorResetButton extends StatelessWidget {
  const CalculatorResetButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: IconButton(
        onPressed: onPressed,
        tooltip: 'Reset',
        icon: const Icon(Icons.refresh_rounded, size: 20),
      ),
    );
  }
}
