import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import 'build_banner_ad.dart';

/// Base layout for the "form + results" calculators.
///
/// Subclasses provide a palette, title and icon; this widget handles the app
/// bar, the tinted background, the scrollable body and the pinned banner ad,
/// so every calculator page looks and behaves the same.
class CalculatorScaffold extends StatelessWidget {
  const CalculatorScaffold({
    super.key,
    required this.palette,
    required this.title,
    required this.icon,
    required this.children,
    this.actions = const <Widget>[],
    this.showBannerAd = true,
    this.controller,
    this.padding = const EdgeInsets.fromLTRB(12, 4, 12, 12),
  });

  final ToolPalette palette;
  final String title;
  final IconData icon;

  /// The calculator's input cards and result tiles.
  final List<Widget> children;

  final List<Widget> actions;
  final bool showBannerAd;
  final ScrollController? controller;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: actions,
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: palette.linear,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 19, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              palette.accent.withValues(alpha: 0.16),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            stops: const <double>[0, 0.28],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
              if (showBannerAd) const BuildBannerAd(),
            ],
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
      padding: const EdgeInsets.only(right: 8),
      child: IconButton(
        onPressed: onPressed,
        tooltip: 'Reset',
        style: IconButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        icon: const Icon(Icons.refresh_rounded, size: 20),
      ),
    );
  }
}
