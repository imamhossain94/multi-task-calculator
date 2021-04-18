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
  return SharedPrefService.prefs.getString(appVersion) ?? '0';
}

//Currency
void setAppPurchasedStatus(bool value) {
  SharedPrefService.prefs.setBool('app_purchase_status', value);
}

bool getAppPurchasedStatus() {
  return SharedPrefService.prefs.getBool('app_purchase_status')??false;
}


void setAdFreeTime(String value) {
  SharedPrefService.prefs.setString('ad_free_time', value);
}

String getAdFreeTime() {
  return SharedPrefService.prefs.getString('ad_free_time')??DateTime.now().toString();
}