import 'package:flutter/material.dart';

import '../components/app_surface.dart';
import '../utils/app_color.dart';
class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Premium'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
        physics: const BouncingScrollPhysics(),
        children: const <Widget>[
          _PerkCard(
            icon: Icons.block_rounded,
            title: 'Every ad, gone',
            body: 'No banner ads at the bottom of the screen and no '
                'interstitials between calculators.',
            palette: AppPalettes.discount,
          ),
          SizedBox(height: 12),
          _PerkCard(
            icon: Icons.all_inclusive_rounded,
            title: 'Unlimited use',
            body: 'No waiting between interstitials. Calculate as much as you '
                'like.',
            palette: AppPalettes.loan,
          ),
          SizedBox(height: 12),
          _PerkCard(
            icon: Icons.auto_awesome_rounded,
            title: 'Support the developer',
            body: 'A one-off purchase keeps the app independent and ad-free for '
                'everyone.',
            palette: AppPalettes.savings,
          ),
          SizedBox(height: 18),
          _ComingSoonCard(),
        ],
      ),
    );
  }
}

class _PerkCard extends StatelessWidget {
  const _PerkCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.palette,
  });

  final IconData icon;
  final String title;
  final String body;
  final ToolPalette palette;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: palette.linear,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Purchases are not wired up, so say so plainly rather than showing a
/// dead "Purchase" button. (The old page had a `$4.99` button that did
/// nothing at all.)
class _ComingSoonCard extends StatelessWidget {
  const _ComingSoonCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Icon(Icons.hourglass_top_rounded,
              size: 40, color: AppColors.warning),
          const SizedBox(height: 12),
          Text(
            'Purchases are not available yet',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'In-app purchases are still being built, so the button is hidden '
            'for now. The app works exactly the same either way â€” it is just '
            'ad supported.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Back to the app',
            icon: Icons.arrow_back_rounded,
            palette: AppPalettes.general,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }
}
