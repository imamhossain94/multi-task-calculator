import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:multi_task_calculator/services/shared_pref_services.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/provider.dart';
import 'package:multi_task_calculator/utils/themes.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:provider/provider.dart';
import 'package:multi_task_calculator/utils/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  MobileAds.instance.initialize();

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  await SharedPrefService().init();
  // GoogleAdService().initInterstitialAd();
  // GoogleAdService().initRewardedAd();

  prefs.then((value) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) {
          String theme = value.getString(appTheme);
          if (theme == null ||
              theme == "" ||
              theme == systemDefault) {
            value.setString(appTheme, systemDefault);
            return ThemeNotifier(ThemeMode.system);
          }
          return ThemeNotifier(theme == dark ? ThemeMode.dark : ThemeMode.light);
        },
        child: MultiTaskCalculator(),
      ),
    );
  });
}

class MultiTaskCalculator extends StatefulWidget {
  @override
  _MultiTaskCalculatorState createState() => _MultiTaskCalculatorState();
}

class _MultiTaskCalculatorState extends State<MultiTaskCalculator> {

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme(),
      darkTheme: AppTheme().darkTheme(),
      themeMode: themeNotifier.getThemeMode(),
      initialRoute: splashPage,
      onGenerateRoute: router.generateRoute,
    );
  }
}

// void confirmPurchase() async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//  // bool isAdsPurchased = await SharedPreferences.getInstance().then((value) => value.getBool('ads_purchase_status') ?? false);
//   bool isAdsPurchased = prefs.getBool('ads_purchase_status') ?? false;
//   await prefs.setBool('ads_purchase_status', true);
// }




