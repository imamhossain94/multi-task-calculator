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
  static int get lastUpdateCheck => _p?.getInt(lastUpdateCheckKey) ?? 0;

  static Future<bool> setLastUpdateCheck(int millis) async {
    await init();
    return _prefs!.setInt(lastUpdateCheckKey, millis);
  }
}
