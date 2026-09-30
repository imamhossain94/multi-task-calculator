import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/extensions.dart';
import '../utils/app_color.dart';
import '../components/app_surface.dart';

/// Support page.
///
/// The app is now completely ad-free, so there is nothing left to unlock and
/// nothing to pay for. The page exists to say thank you and to point at the
/// things that genuinely help: a review, a bug report, and the other apps.
class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        physics: const BouncingScrollPhysics(),
        children: const <Widget>[
          _ThankYouCard(),
          SizedBox(height: 12),
          _PerkCard(
            icon: Icons.block_rounded,
            title: 'No ads, anywhere',
            body: 'No banners, no interstitials, no tracking. The whole app is '
                'free and stays that way.',
            palette: AppPalettes.tip,
          ),
          SizedBox(height: 12),
          _PerkCard(
            icon: Icons.wifi_off_rounded,
            title: 'Works offline',
            body: 'Every calculator runs on your device. Nothing is uploaded, '
                'and nothing is needed at sign-in.',
            palette: AppPalettes.unitConverter,
          ),
          SizedBox(height: 12),
          _PerkCard(
            icon: Icons.volunteer_activism_rounded,
            title: 'How to help',
            body: 'A review on the Play Store is the single most useful thing '
                'you can do. Bug reports are just as welcome.',
            palette: AppPalettes.general,
          ),
          SizedBox(height: AppSpacing.lg),
          _CallToActionCard(),
        ],
      ),
    );
  }
}

class _ThankYouCard extends StatelessWidget {
  const _ThankYouCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.brand,
        borderRadius: AppRadii.allLg,
        border: Border.all(
          color: AppColors.brand,
          width: AppBorders.hairline,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.18),
            ),
            child: const Icon(
              Icons.favorite_rounded,
              size: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Thank you',
            style: TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'This app is free, ad-free and open to everyone.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13.5,
            ),
          ),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: palette.accent,
                borderRadius: AppRadii.allMd,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: AppSpacing.md),
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
      ),
    );
  }
}

class _CallToActionCard extends StatelessWidget {
  const _CallToActionCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppButton(
              label: 'Rate the app',
              icon: Icons.star_rounded,
              palette: AppPalettes.discount,
              onPressed: () => onRatingPressed(context),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Send feedback',
              icon: Icons.mail_outline_rounded,
              palette: AppPalettes.general,
              onPressed: () => openExternal(context, feedbackMail),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Our other apps',
              icon: Icons.apps_rounded,
              palette: AppPalettes.unitConverter,
              onPressed: () => openExternal(context, storeLink),
            ),
          ],
        ),
      ),
    );
  }
}
