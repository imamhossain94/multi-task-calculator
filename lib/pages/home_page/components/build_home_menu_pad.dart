import 'package:flutter/material.dart';
import '../../../services/google_ad_service.dart';

import 'build_home_menu_button.dart';

/// The grid of calculator tiles on the home screen.
class BuildHomeMenuPad extends StatelessWidget {
  const BuildHomeMenuPad({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Three columns on a phone, five on a tablet.
        final int columns = constraints.maxWidth > 600 ? 5 : 3;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(6, 4, 6, 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 0.92,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: homeMenuEntries.length,
          itemBuilder: (BuildContext context, int index) {
            final HomeMenuEntry entry = homeMenuEntries[index];
            return BuildHomeMenuButton(
              title: entry.title,
              icon: entry.icon,
              color: entry.palette.accent,
              onPressed: () => _open(context, entry.route),
            );
          },
        );
      },
    );
  }

  Future<void> _open(BuildContext context, String route) async {
    await showInterstitialAd();
    if (!context.mounted) return;
    await Navigator.of(context).pushNamed(route);
  }
}