import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/history_service.dart';
import '../../../services/shared_pref_services.dart';
import '../../../utils/app_color.dart';
import '../../../utils/constant.dart';
import '../../../utils/extensions.dart';
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
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
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
                    trailing: historyCount == 0
                        ? null
                        : '$historyCount',
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
                      ShareParams(text: 'Check out $appName on the Play Store: $appLink'),
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
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[AppColors.brand, AppColors.brandAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.45),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(appIconLight, height: 74, width: 74),
            ),
          ),
          const SizedBox(height: 12),
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
          const SizedBox(height: 4),
          Text(
            'Every calculator in one place',
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
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: <Widget>[
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(icon, size: 18, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (trailing != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      trailing!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  const Icon(Icons.chevron_right_rounded, size: 20),
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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(
          height: 1,
          color: Theme.of(context).textTheme.bodySmall?.color?.withValues(
                alpha: 0.15,
              ),
        ),
      );
}
