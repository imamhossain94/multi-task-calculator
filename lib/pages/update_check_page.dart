import 'package:flutter/material.dart';

import '../services/app_version_service.dart';
import '../services/shared_pref_services.dart';
import '../utils/constant.dart';
import '../utils/extensions.dart';
import '../utils/app_color.dart';
import '../components/app_surface.dart';

/// Manual "check for update" screen.
///
/// The previous version read the latest version from a Firestore collection.
/// Firebase has been removed, so this now fetches a small JSON manifest over
/// HTTPS —” which also fixes the crash that happened whenever the collection
/// had no document (both `latestAppVersion` and `currentAppVersion` were left
/// null and then compared).
class UpdateCheckPage extends StatefulWidget {
  const UpdateCheckPage({super.key});

  @override
  State<UpdateCheckPage> createState() => _UpdateCheckPageState();
}

class _UpdateCheckPageState extends State<UpdateCheckPage> {
  UpdateInfo? _info;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  Future<void> _check() async {
    if (!mounted) return;
    setState(() {
      _isChecking = true;
      _info = null;
    });

    // Remember the running version for the About screen and the drawer.
    final String installed = await AppVersionService.installedVersion();
    if (installed.isNotEmpty) {
      await SharedPrefService.setAppVersion(installed);
    }
    await SharedPrefService.setLastUpdateCheck(
      DateTime.now().millisecondsSinceEpoch,
    );

    final UpdateInfo info = await AppVersionService().check();
    if (!mounted) return;
    setState(() {
      _isChecking = false;
      _info = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Software Update'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _isChecking ? null : _check,
            tooltip: 'Check again',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          AppAccentCard(
            palette: AppPalettes.neutral,
            child: Row(
              children: <Widget>[
                Image.asset(appIconLight, height: 56, width: 56),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        appName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Audiowide',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Installed: ${_info?.currentVersion.isNotEmpty ?? false ? _info!.currentVersion : '—”'}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_isChecking)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.lg),
                  Text('Checking for an update…'),
                ],
              ),
            )
          else if (_info != null)
            _StatusCard(info: _info!, onRetry: _check),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.info, required this.onRetry});

  final UpdateInfo info;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    late final String title;
    late final String body;
    late final Color color;
    final bool showUpdate = info.status == UpdateStatus.updateAvailable;
    final bool force = info.status == UpdateStatus.forceUpdate;

    switch (info.status) {
      case UpdateStatus.upToDate:
        icon = Icons.check_circle_rounded;
        title = 'You are up to date';
        body = 'You are running the latest version '
            '(${info.currentVersion}). Nothing to do.';
        color = AppColors.success;
      case UpdateStatus.updateAvailable:
        icon = Icons.system_update_rounded;
        title = 'Update available';
        body = 'Version ${info.latestVersion} is on the Play Store.';
        color = AppColors.info;
      case UpdateStatus.forceUpdate:
        icon = Icons.warning_amber_rounded;
        title = 'Update required';
        body = 'Please update to version ${info.latestVersion} to keep using '
            'the app.';
        color = AppColors.danger;
      case UpdateStatus.failed:
        icon = Icons.cloud_off_rounded;
        title = 'Could not check';
        body = info.error ?? 'Something went wrong. Please try again.';
        color = AppColors.warning;
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5,
              height: 1.4,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          if (info.notes != null && info.notes!.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: AppRadii.allMd,
              ),
              child: Text(
                info.notes!,
                style: const TextStyle(fontSize: 13.5, height: 1.4),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          if (showUpdate || force)
            AppButton(
              label: 'Update now',
              icon: Icons.download_rounded,
              palette: AppPalettes.general,
              onPressed: () => openExternal(context, appLink),
            )
          else
            AppButton(
              label: 'Check again',
              icon: Icons.refresh_rounded,
              palette: AppPalettes.neutral,
              onPressed: onRetry,
            ),
        ],
      ),
    );
  }
}
