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

//Currency
void setCurrencyLastUpdate(String time) {
  SharedPrefService.prefs.setString('time_last_update_utc', time.substring(0,16));
}

String getCurrencyLastUpdate() {
  String value = SharedPrefService.prefs.getString('time_last_update_utc');
  return value;
}

void setCurrencyNextUpdate(String time) {
  int value = int.parse('${time[5]}${time[5]}');
  SharedPrefService.prefs.setInt('time_next_update_utc', value);
}

int getCurrencyNextUpdate() {
  int value = SharedPrefService.prefs.getInt('time_next_update_utc')??DateTime.now().day.toInt();
  return value;
}
//Currency

