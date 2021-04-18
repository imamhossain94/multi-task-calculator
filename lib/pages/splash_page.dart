import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_app_logo.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  void checkForUpdate() async{
    Version latestAppVersion, currentAppVersion;
    bool forceUpdate;

    await fireStoreInstance.collection("version").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        var data = result.data();
        latestAppVersion = Version.parse(data['appVersion']);
        forceUpdate = data['forceUpdate'];
      });
    });

    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) async{
      String version = packageInfo.version;
      currentAppVersion = Version.parse(version);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(appVersion, version);
    });

    if(latestAppVersion > currentAppVersion){
      if(forceUpdate){
        emergencyUpdateDialogue(context);
      }else{
        if(!await appUpdateDialogue(context)){
          Navigator.pushReplacementNamed(context, homePage);
        }
      }
    }else{
      Navigator.pushReplacementNamed(context, homePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    ScreenConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: Center(child: BuildAppLogo()),
      ),
    );
  }
}
