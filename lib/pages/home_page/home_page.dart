import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/build_banner_ad.dart';
import '../../services/app_version_service.dart';
import '../../utils/app_color.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import 'components/build_app_drawer.dart';
import 'components/build_home_menu_pad.dart';

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
    final Color background = Theme.of(context).scaffoldBackgroundColor;

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
        extendBodyBehindAppBar: true,
        drawerScrimColor: Colors.black.withValues(alpha: 0.35),
        appBar: AppBar(
          titleSpacing: 4,
          title: Row(
            children: <Widget>[
              Image.asset(appIconLight, height: 30, width: 30),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  appName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Audiowide',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(historyPage),
              tooltip: 'History',
              icon: const Icon(Icons.history_rounded, size: 21),
            ),
            IconButton(
              onPressed: _share,
              tooltip: 'Share',
              icon: const Icon(Icons.share_rounded, size: 20),
            ),
            const SizedBox(width: 4),
          ],
        ),
        drawer: const BuildAppDrawer(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                AppColors.brand.withValues(alpha: 0.20),
                background,
                background,
              ],
              stops: const <double>[0, 0.24, 1],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: const BuildHomeMenuPad(),
                  ),
                ),
                const BuildBannerAd(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
