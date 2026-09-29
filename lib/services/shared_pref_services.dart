import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';
/// Thin, typed wrapper around [SharedPreferences].
///
/// The previous implementation kept the instance in a mutable static and read
/// it from free functions, which meant any call before [init] threw. Values are
/// now resolved lazily and every getter has a safe default.
class SharedPrefService {
  SharedPrefService._();

  static SharedPreferences? _prefs;
  static bool _initialised = false;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    _initialised = true;
  }

  static SharedPreferences? get _p => _initialised ? _prefs : null;

  // ------------------------------------------------------------------ theme
  static String get theme => _p?.getString(appTheme) ?? systemDefault;

  static Future<bool> setTheme(String value) async {
    await init();
    return _prefs!.setString(appTheme, value);
  }

  // ----------------------------------------------------------------- version
  static String get appVersion => _p?.getString(appVersionKey) ?? '';

  static Future<bool> setAppVersion(String value) async {
    await init();
    return _prefs!.setString(appVersionKey, value);
  }

  // -------------------------------------------------------------------- ads
  static bool get isAdFree =>
      _p?.getBool(appPurchasedStatusKey) ?? false;

  static Future<bool> setAdFree(bool value) async {
    await init();
    return _prefs!.setBool(appPurchasedStatusKey, value);
  }

  /// Records that an interstitial was shown. Returns `true` when this tap is
  /// the one that should actually show an ad (i.e. every Nth tap).
  static Future<bool> shouldShowInterstitial() async {
    await init();
    final int counter = (_prefs!.getInt(itemClickKey) ?? 0) + 1;
    await _prefs!.setInt(itemClickKey, counter);
    if (isAdFree) return false;
    return counter % interstitialTapInterval == 0;
  }

  // ------------------------------------------------------- reward ad timer
  static String get adFreeUntil => _p?.getString(adFreeTimeKey) ?? 'zero';

  static Future<bool> setAdFreeUntil(String value) async {
    await init();
    return _prefs!.setString(adFreeTimeKey, value);
  }

  // ---------------------------------------------------------------- history
  static String get historyJson => _p?.getString(historyKey) ?? '[]';

  static Future<bool> setHistoryJson(String value) async {
    await init();
    return _prefs!.setString(historyKey, value);
  }

  static Future<bool> clearHistory() async {
    await init();
    return _prefs!.remove(historyKey);
  }

  // -------------------------------------------------------- update checking
  static int get lastUpdateCheck =>
      _p?.getInt(lastUpdateCheckKey) ?? 0;

  static Future<bool> setLastUpdateCheck(int millis) async {
    await init();
    return _prefs!.setInt(lastUpdateCheckKey, millis);
  }
}
