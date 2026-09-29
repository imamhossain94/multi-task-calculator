import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'services/google_ad_service.dart';
import 'services/shared_pref_services.dart';
import 'utils/constant.dart';
import 'utils/provider.dart';
import 'utils/router.dart' as router;
import 'utils/themes.dart';
import 'utils/themes_mode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SharedPrefService.init();

  // Never block first paint on the network: a slow or failed AdMob init must
  // not stop the app from opening. `showInterstitialAd` no-ops if the SDK
  // never finished initialising.
  unawaited(GoogleAdService.init());

  runApp(const MultiTaskCalculator());
}

/// Resolves the saved theme, defaulting to the system setting.
ThemeMode _initialThemeMode() {
  final String stored = SharedPrefService.theme;
  switch (stored) {
    case dark:
      return ThemeMode.dark;
    case light:
      return ThemeMode.light;
    default:
      return ThemeMode.system;
  }
}

/// App root.
///
/// The [ChangeNotifierProvider] lives *inside* this widget rather than in
/// [main] so the app can be mounted directly from a test without the caller
/// having to replicate the provider wiring.
class MultiTaskCalculator extends StatelessWidget {
  const MultiTaskCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (BuildContext _) => ThemeNotifier(_initialThemeMode()),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeNotifier.getThemeMode(),
      initialRoute: homePage,
      onGenerateRoute: router.generateRoute,
      builder: (BuildContext context, Widget? child) {
        ThemesMode.sync(context);
        // Clamp text scaling so the dense calculator layouts stay usable.
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaler: data.textScaler.clamp(
              minScaleFactor: 0.85,
              maxScaleFactor: 1.30,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

