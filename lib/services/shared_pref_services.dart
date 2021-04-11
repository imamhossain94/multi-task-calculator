import 'package:multi_task_calculator/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences prefs;
  void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

//themes
int getSavedTheme() {
  return themes.indexOf(SharedPrefService.prefs.getString(appTheme) ?? systemDefault);
}

String getAppVersion() {
  return SharedPrefService.prefs.getString(appVersion) ?? '--';
}


