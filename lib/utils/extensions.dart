import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_color.dart';
import '../utils/constant.dart';
import '../utils/provider.dart';
import '../utils/screen_config.dart';
import '../utils/themes_mode.dart';
// ===========================================================================
// Navigation helpers
// ===========================================================================

/// Replaces the current route with [widget], with no transition animation.
void resetPage(BuildContext context, Widget widget) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (_, __, ___) => widget,
    ),
  );
}

/// Opens [url] in the browser, falling back to a snackbar instead of throwing.
///
/// `url_launcher`'s `canLaunch` is deprecated and the previous code did
/// `throw 'Could not launch ...'`, which surfaced as a red error screen in
/// release when no browser was installed.
Future<void> openExternal(BuildContext context, String url) async {
  // Capture the messenger *before* awaiting: the await yields, and using a
  // stale context would throw in a release build.
  final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(context);

  final Uri? uri = Uri.tryParse(url);
  if (uri == null) {
    _showFlush(messenger, 'Could not open link', Icons.link_off_rounded);
    return;
  }
  try {
    final bool ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) _showFlush(messenger, 'Could not open link', Icons.link_off_rounded);
  } catch (_) {
    _showFlush(messenger, 'Could not open link', Icons.link_off_rounded);
  }
}

// ===========================================================================
// Bottom sheet helper
// ===========================================================================

/// A styled draggable bottom sheet used by every picker in the app.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required String title,
  required Widget Function(BuildContext, ScrollController) builder,
  double maxChildSize = 0.85,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    barrierColor: ThemesMode.isDarkMode
        ? Colors.black.withValues(alpha: 0.6)
        : Colors.black.withValues(alpha: 0.25),
    builder: (BuildContext sheetContext) {
      return DraggableScrollableSheet(
        maxChildSize: maxChildSize,
        minChildSize: 0.35,
        initialChildSize: maxChildSize,
        expand: false,
        builder: (BuildContext _, ScrollController controller) {
          return Container(
            decoration: BoxDecoration(
              color: ThemesMode.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 4),
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: ThemesMode.onSurfaceMuted.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: ThemesMode.onSurface,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.of(sheetContext).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(child: builder(sheetContext, controller)),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// ===========================================================================
// Toasts
// ===========================================================================

void _showFlush(
  ScaffoldMessengerState? messenger,
  String message,
  IconData icon,
) {
  if (messenger == null) return;
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
}

/// Shows a floating toast. [title] is optional.
void showMessage(BuildContext context, String? title, String message) {
  if (!context.mounted) return;
  // ignore: use_build_context_synchronously
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(14),
    margin: const EdgeInsets.all(12),
    backgroundColor: ThemesMode.isDarkMode
        ? AppColors.darkSurfaceAlt
        : AppColors.textDark,
    icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
    title: title?.isEmpty ?? true ? null : title,
    message: message,
    duration: const Duration(seconds: 3),
    maxWidth: 520,
  ).show(context);
}

// ===========================================================================
// Dialogs
// ===========================================================================

/// "Rate this app" sheet. 1â€“3 stars routes to feedback, 4â€“5 to the store.
Future<void> onRatingPressed(BuildContext context) async {
  await showAppBottomSheet<void>(
    context: context,
    title: 'Rate the app',
    maxChildSize: 0.5,
    builder: (BuildContext sheetContext, _) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.star_rounded, color: AppColors.warning),
              const SizedBox(width: 8),
              Text(
                'Rate the app',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Audiowide',
                  color: ThemesMode.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'If you like this app, please take a minute to review it. '
            'It really helps.',
            style: TextStyle(fontSize: 15, color: ThemesMode.onSurfaceMuted),
          ),
          const SizedBox(height: 22),
          Row(
            children: List<Widget>.generate(5, (int i) {
              final int value = i + 1;
              final Color color =
                  value <= 3 ? AppColors.danger : AppColors.success;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        if (value <= 3) {
                          Navigator.of(context)
                              .pushNamed(feedbackPage);
                        } else {
                          openExternal(context, appLink);
                        }
                      },
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          '$value',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

/// Exit confirmation, shown when the back button is pressed on the home page.
Future<bool> onBackPressed(BuildContext context) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      title: Row(
        children: <Widget>[
          const Icon(Icons.logout_rounded, color: AppColors.danger),
          const SizedBox(width: 10),
          Text(
            'Exit app?',
            style: TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 19,
              color: ThemesMode.onSurface,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to quit $appName?',
        style: TextStyle(color: ThemesMode.onSurfaceMuted),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Stay'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Exit'),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Theme picker.
Future<void> themeChoiceDialogue(BuildContext context) async {
  await showAppBottomSheet<void>(
    context: context,
    title: 'Choose theme',
    maxChildSize: 0.55,
    builder: (BuildContext sheetContext, _) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          _ThemeOption(
            value: systemDefault,
            icon: Icons.brightness_auto_rounded,
            label: 'System default',
            color: AppColors.success,
          ),
          _ThemeOption(
            value: light,
            icon: Icons.wb_sunny_rounded,
            label: 'Light',
            color: AppColors.warning,
          ),
          _ThemeOption(
            value: dark,
            icon: Icons.nightlight_round,
            label: 'Dark',
            color: Color(0xFF7C3AED),
          ),
        ],
      ),
    ),
  );
}

/// A single selectable row in [themeChoiceDialogue].
class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.value,
    required this.icon,
    required this.label,
    required this.color,
  });

  final String value;
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            final ThemeNotifier notifier =
                Provider.of<ThemeNotifier>(context, listen: false);
            // ignore: unnecessary_breaks_in_finally
            switch (value) {
              case dark:
                notifier.setThemeMode(ThemeMode.dark);
              case light:
                notifier.setThemeMode(ThemeMode.light);
              default:
                notifier.setThemeMode(ThemeMode.system);
            }
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString(appTheme, value);
            if (context.mounted) Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Icon(icon, size: 20, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ThemesMode.onSurface,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right_rounded,
                    color: ThemesMode.onSurfaceMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Blocking "you must update" dialog.
Future<void> emergencyUpdateDialogue(BuildContext context, String version) {
  return _updateDialogue(
    context: context,
    version: version,
    force: true,
    title: 'Update required',
    message: 'Please update to version $version to keep using the app.',
    actions: <Widget>[_updateButton(context, 'Update now')],
  );
}

/// Dismissible "an update is available" dialog.
Future<void> appUpdateDialogue(BuildContext context, String version) {
  return _updateDialogue(
    context: context,
    version: version,
    force: false,
    title: 'Update available',
    message: 'Version $version is available on the Play Store.',
    actions: <Widget>[
      _updateButton(context, 'Update now'),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Later'),
      ),
    ],
  );
}

Widget _updateButton(BuildContext context, String label) => FilledButton.icon(
      style: FilledButton.styleFrom(backgroundColor: AppColors.brand),
      onPressed: () => openExternal(context, appLink),
      icon: const Icon(Icons.system_update_rounded, size: 18),
      label: Text(label),
    );

Future<void> _updateDialogue({
  required BuildContext context,
  required String version,
  required bool force,
  required String title,
  required String message,
  required List<Widget> actions,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: !force,
    builder: (BuildContext dialogContext) => PopScope(
      canPop: !force,
      child: AlertDialog(
        icon: Icon(
          force ? Icons.warning_amber_rounded : Icons.system_update_rounded,
          color: force ? AppColors.danger : AppColors.brand,
          size: 34,
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Audiowide', fontSize: 19),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: ThemesMode.onSurfaceMuted),
        ),
        actions: actions,
        actionsAlignment: MainAxisAlignment.center,
      ),
    ),
  );
}

/// "Clear all history" confirmation.
Future<bool> onDeletePressed(BuildContext context) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      icon: const Icon(Icons.delete_forever_rounded,
          color: AppColors.danger, size: 34),
      title: const Text('Clear all history?'),
      content: const Text(
        'Every saved calculation will be removed. This cannot be undone.',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Clear'),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Small helper so pages can size text without importing [screen_config].
double scaleText(double value) => responsiveText(value);
