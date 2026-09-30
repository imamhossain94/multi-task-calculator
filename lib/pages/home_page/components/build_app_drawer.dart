import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/history_service.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/constant.dart';
import '../../../utils/extensions.dart';
import '../../../utils/app_color.dart';

class BuildAppDrawer extends StatelessWidget {
  const BuildAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final int historyCount = HistoryService.load().length;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const _DrawerHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.lg),
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  _DrawerItem(
                    icon: Icons.palette_rounded,
                    color: AppColors.warning,
                    label: 'Themes',
                    onTap: () => themeChoiceDialogue(context),
                  ),
                  _DrawerItem(
                    icon: Icons.history_rounded,
                    color: AppPalettes.history.accent,
                    label: 'History',
                    trailing: historyCount == 0 ? null : '$historyCount',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(historyPage);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.help_rounded,
                    color: AppColors.danger,
                    label: 'Help & FAQ',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(helpPage);
                    },
                  ),
                  const _DrawerDivider(),
                  _DrawerItem(
                    icon: Icons.star_rounded,
                    color: AppPalettes.discount.accent,
                    label: 'Rate the app',
                    onTap: () => onRatingPressed(context),
                  ),
                  _DrawerItem(
                    icon: Icons.share_rounded,
                    color: AppPalettes.general.accent,
                    label: 'Share',
                    onTap: () => SharePlus.instance.share(
                      ShareParams(
                          text:
                              'Check out $appName on the Play Store: $appLink'),
                    ),
                  ),
                  _DrawerItem(
                    icon: Icons.workspace_premium_rounded,
                    color: AppPalettes.savings.accent,
                    label: 'Premium',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(premiumPage);
                    },
                  ),
                  const _DrawerDivider(),
                  _DrawerItem(
                    icon: Icons.apps_rounded,
                    color: AppColors.warning,
                    label: 'Our other apps',
                    onTap: () => openExternal(context, storeLink),
                  ),
                  _DrawerItem(
                    icon: Icons.mail_outline_rounded,
                    color: AppPalettes.loan.accent,
                    label: 'Send an email',
                    onTap: () => openExternal(context, contactMail),
                  ),
                  _DrawerItem(
                    icon: Icons.info_outline_rounded,
                    color: AppPalettes.fuelEfficiency.accent,
                    label: 'About',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(aboutPage);
                    },
                  ),
                  const _DrawerDivider(),
                  _DrawerItem(
                    icon: Icons.system_update_rounded,
                    color: Colors.orange,
                    label: 'Check for update',
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(updateCheckPage);
                    },
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      '$appName ${SharedPrefService.appVersion}',
                      style: const TextStyle(fontSize: 11.5),
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

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppPalettes.general.accent,
        border: const Border(
          bottom:
              BorderSide(color: AppColors.brand, width: AppBorders.hairline),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: AppRadii.allLg,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.45),
                width: AppBorders.strong,
              ),
            ),
            child: ClipRRect(
              borderRadius: AppRadii.allMd,
              child: Image.asset(appIconLight, height: 68, width: 68),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            appName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Every calculator in one place',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadii.allMd,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm + 2),
            child: Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: AppRadii.allSm,
                  ),
                  child: Icon(icon, size: 16, color: Colors.white),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (trailing != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: AppRadii.allXs,
                    ),
                    child: Text(
                      trailing!,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  const Icon(Icons.chevron_right_rounded, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerDivider extends StatelessWidget {
  const _DrawerDivider();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Divider(height: 1),
      );
}
