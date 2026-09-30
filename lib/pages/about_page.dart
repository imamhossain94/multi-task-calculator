import 'package:flutter/material.dart';

import '../services/shared_pref_services.dart';
import '../utils/constant.dart';
import '../utils/extensions.dart';
import '../utils/app_color.dart';
import '../components/app_surface.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 24),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          _LogoCard(),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Development',
            rows: <(String, String)>[
              ('Developer', developerName),
              ('UI design', designerName),
              ('Platforms', 'Android · iOS'),
              ('Icons', 'Font Awesome · custom'),
            ],
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'What is $appName?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...appFeature.map(
                  (String feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.check_circle_rounded,
                            size: 17, color: AppColors.success),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(fontSize: 14, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Everything offline',
            rows: const <(String, String)>[
              ('Account required', 'No'),
              ('Data collected', 'Nothing'),
              ('Works offline', 'Yes, all of it'),
            ],
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: <Widget>[
                AppButton(
                  label: 'Our other apps',
                  icon: Icons.apps_rounded,
                  palette: AppPalettes.unitConverter,
                  onPressed: () => openExternal(context, storeLink),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Rate $appName',
                  icon: Icons.star_rounded,
                  palette: AppPalettes.discount,
                  onPressed: () => onRatingPressed(context),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Privacy policy',
                  icon: Icons.privacy_tip_rounded,
                  palette: AppPalettes.salesTax,
                  onPressed: () => openExternal(context, privacyPolicyLink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppAccentCard(
      palette: AppPalettes.general,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        children: <Widget>[
          Image.asset(appIconLight, height: 84, width: 84),
          const SizedBox(height: AppSpacing.md),
          Text(
            appName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 21,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Version ${SharedPrefService.appVersion}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.rows});

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          ...rows.map(
            ((String, String) row) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      row.$1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      row.$2,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
