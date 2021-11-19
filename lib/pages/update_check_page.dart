import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_task_calculator/components/build_app_logo.dart';
import 'package:multi_task_calculator/services/shared_pref_services.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateCheckPage extends StatefulWidget {
  @override
  _UpdateCheckPageState createState() => _UpdateCheckPageState();
}

class _UpdateCheckPageState extends State<UpdateCheckPage> {

  final fireStoreInstance = FirebaseFirestore.instance;
  Version latestAppVersion, currentAppVersion;
  bool forceUpdate, isUpdated, isLoading = true;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }


  void checkForUpdate() async{

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
      isUpdated = false;
    }else{
      isUpdated = true;
    }

    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Software Update',
              style: TextStyle(
                  fontSize: responsiveText(22),
                  fontFamily: fontAudioWide,
              ),
            ),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(30),
                      color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                      child: BuildAppLogo()
                  )
                ),
                Expanded(
                  flex: 1,
                  child:isLoading? loading():
                  isUpdated?noUpdate():forceUpdate?emergencyUpdate():regularUpdate(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '$appName: ${getAppVersion()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: responsiveText(16),
                        fontWeight: FontWeight.bold
                      )
                  ),
                )

              ],
            ),
          )),
    );
  }

  Widget loading(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              ThemesMode.isDarkMode?Colors.white12:Colors.black45
          ),
        ),
        SizedBox(
          height: responsiveHeight(30),
        ),
        Text(
            'Please wait\nwhile we are checking\nfor an update.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: responsiveText(16),
                fontWeight: FontWeight.bold,
                color: ThemesMode.isDarkMode?Colors.white12:Colors.black45
            )
        ),
      ],
    );
  }

  Widget noUpdate(){
    return Container(
      alignment: Alignment.center,
      child: Text(
          'NO UPDATE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsiveText(34),
            fontFamily: fontAudioWide,
            color: ThemesMode.isDarkMode?Colors.white12:Colors.black12
          )
      ),
    );
  }

  Widget emergencyUpdate(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Emergency Update Available',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: responsiveText(18),
                  fontWeight: FontWeight.bold
              )
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 25),
            child: Text(
                'Please update this app to continue with the new version: $latestAppVersion',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: responsiveText(16),
                    fontWeight: FontWeight.bold,
                    color: ThemesMode.isDarkMode?Colors.white12:Colors.black45
                )
            ),
          ),

          buildHeaderClickable(
              title: 'Update Now',
              color: textBlue.withOpacity(0.7),
              onPressed: () async{
                if (await canLaunch(appLink)) {
                await launch(appLink);
                } else {
                throw 'Could not launch $appLink';
                }
              }
          ),
        ],
      ),
    );
  }

  Widget regularUpdate(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Update Available',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: responsiveText(18),
                  fontWeight: FontWeight.bold
              )
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 25),
            child: Text(
                'A newer version ($latestAppVersion) of this app is available',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: responsiveText(16),
                    fontWeight: FontWeight.bold,
                    color: ThemesMode.isDarkMode?Colors.white12:Colors.black45
                )
            ),
          ),

          buildHeaderClickable(
            title: 'Update Now',
            color: textBlue.withOpacity(0.7),
            onPressed: () async{
              if (await canLaunch(appLink)) {
                await launch(appLink);
              } else {
                throw 'Could not launch $appLink';
              }
            }
          ),
          buildHeaderClickable(
              title: 'Not Now',
              color: textRed.withOpacity(0.7),
              onPressed: (){
                Navigator.pop(context);
              }
          ),

        ],
      ),
    );
  }

  Widget buildHeaderClickable({String title, VoidCallback onPressed, Color color}) {
    return Material(
      color: Colors.transparent,
      child: new InkWell(
          onTap: () {
            onPressed();
            //print("tapped");
          },
          child: Container(
            height: responsiveHeight(40),
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(0.12),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: responsiveText(16),
                  color: color
                  //fontWeight: FontWeight.bold
              ),
            ),
          )
      ),
    );
  }

}
