import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/app_version_service.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import 'components/build_app_drawer.dart';
import 'components/build_home_menu_pad.dart';
import '../../utils/themes_mode.dart';
import '../../utils/app_color.dart';
import '../../components/app_surface.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Deferred so the first frame is not blocked on a network call.
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkForUpdate());
  }

  /// Silently checks for a blocking update. Failures are ignored: the manual
  /// "Check for update" screen in the drawer reports problems properly.
  Future<void> _checkForUpdate() async {
    final UpdateInfo info = await AppVersionService().check();
    if (!mounted) return;
    if (info.status == UpdateStatus.forceUpdate) {
      await emergencyUpdateDialogue(context, info.latestVersion ?? '');
    }
  }

  Future<void> _share() async {
    await SharePlus.instance.share(
      ShareParams(text: 'Check out $appName: $appLink'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? _) async {
        if (didPop) return;
        if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
          Navigator.of(context).pop();
          return;
        }
        final bool exit = await onBackPressed(context);
        if (exit) {
          // Give the dialog a frame to close before tearing down the tree.
          await Future<void>.delayed(const Duration(milliseconds: 120));
          if (mounted) SystemNavigator.pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawerScrimColor: Colors.black.withValues(alpha: 0.35),
        appBar: AppTitleBar(
          palette: AppPalettes.general,
          title: appName,
          leading: const SizedBox.shrink(),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(historyPage),
              tooltip: 'History',
              icon: const Icon(Icons.history_rounded, size: 20),
            ),
            IconButton(
              onPressed: _share,
              tooltip: 'Share',
              icon: const Icon(Icons.share_rounded, size: 19),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
        ),
        drawer: const BuildAppDrawer(),
        body: Container(
          color: ThemesMode.background,
          child: SafeArea(
            top: false,
            bottom: false,
            child: const BuildHomeMenuPad(),
          ),
        ),
      ),
    );
  }
}
