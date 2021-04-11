import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_rating_view.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/provider.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



void showMessage(BuildContext context, String title, String message){
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    borderRadius: 10,
    margin: EdgeInsets.all(10),
    title: title,
    message: message,
    duration: Duration(seconds: 3),
  )..show(context);
}

Future<bool> onRatingPressed(BuildContext context) async {
  return showDialog(
    barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.white54,
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Center(
        child: Wrap(children: [
          Container(
            clipBehavior: Clip.none,
            margin: EdgeInsets.all(responsiveWidth(8)),
            padding: EdgeInsets.fromLTRB(responsiveWidth(15), responsiveWidth(10), responsiveWidth(15), responsiveWidth(15)),
            decoration: BoxDecoration(
                color: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
                borderRadius: BorderRadius.circular(responsiveWidth(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      blurRadius: responsiveWidth(1),
                      spreadRadius: responsiveWidth(1),
                      offset: Offset.zero)
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.star_rate_rounded,
                      size: responsiveHeight(24),
                      color: textRed,
                    ),
                    SizedBox(
                      width: responsiveWidth(10),
                    ),
                    Text(
                      'Rate The App',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: fontAudioWide,
                        fontSize: responsiveText(20),
                        decoration: TextDecoration.none,
                        color: ThemesMode.isDarkMode?textWhite:textBlack,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'If you like this app, please take a little bit of time to review it!\n'
                  'It really help us and it shouldn\'t take you more than one minute',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: responsiveText(16),
                    //fontFamily: null,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: ThemesMode.isDarkMode?textWhite:textBlack,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BuildRatingValue(
                        value: 1,
                        color: Colors.red.withOpacity(1),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      BuildRatingValue(
                          value: 2, color: Colors.red.withOpacity(0.9),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      BuildRatingValue(
                        value: 3,
                        color: Colors.red.withOpacity(0.7),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      BuildRatingValue(
                        value: 4,
                        color: Colors.green.withOpacity(0.9),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      BuildRatingValue(
                        value: 5,
                        color: Colors.green.withOpacity(1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    },
  );
}

//Home Page Back Press
Future<bool> onBackPressed(BuildContext context) async {
  return showModalBottomSheet(
    barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.white54,
    context: context,
    elevation: 0.0,
    builder: (context) {
      return Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(responsiveWidth(8)),
        padding: EdgeInsets.fromLTRB(responsiveWidth(15), responsiveWidth(10), responsiveWidth(15), responsiveWidth(15)),
        decoration: BoxDecoration(
            color: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
            //border: Border.all(width: 0.5, color: Colors.black12),
            borderRadius: BorderRadius.circular(responsiveWidth(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: responsiveWidth(3),
                  spreadRadius: responsiveWidth(3),
                  offset: Offset.zero)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  appIconLight,
                  height: responsiveWidth(20),
                  width: responsiveWidth(20),
                ),
                SizedBox(
                  width: responsiveWidth(10),
                ),
                Text(
                  appName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: fontAudioWide,
                    fontSize: responsiveText(20),
                    decoration: TextDecoration.none,
                    color: ThemesMode.isDarkMode?textWhite:textBlack,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: responsiveHeight(10),
            ),
            Text(
              'Are you sure, You want to EXIT?',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: responsiveText(20),
                //fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: ThemesMode.isDarkMode?textWhite:textBlack,
              ),
            ),
            SizedBox(
              height: responsiveHeight(20),
            ),
            SizedBox(
              height: responsiveHeight(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      padding: EdgeInsets.zero,
                      color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                      child: Text(
                          'No',
                        style: TextStyle(
                          fontSize: responsiveText(16),
                          //fontFamily: null,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: ThemesMode.isDarkMode?textBlue:textBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: responsiveWidth(15),
                  ),
                  Expanded(
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      padding: EdgeInsets.zero,
                      color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Text(
                            'Yes',
                          style: TextStyle(
                            fontSize: responsiveText(16),
                            //fontFamily: null,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            color: ThemesMode.isDarkMode?textOrange:textRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<bool> onDeletePressed(BuildContext context) async {
  return showDialog(
    barrierColor: Colors.white54,
    context: context,
    builder: (context) {
      return Center(
        child: Wrap(children: [
          Container(
            clipBehavior: Clip.none,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
            decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(width: 0.5, color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      blurRadius: 3,
                      spreadRadius: 3,
                      offset: Offset.zero)
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.warning_rounded,
                      size: 30,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Clear All History',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Are you sure you want to clear all data?\nBe careful, the process cannot be undone.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          padding: EdgeInsets.zero,
                          color: Colors.blueAccent,
                          child: Text('No'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          padding: EdgeInsets.zero,
                          color: Colors.redAccent,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 30, right: 30),
                            child: Text('Yes'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    },
  ).then((value) => value == null?false:value);

}

//Emergency Update Dialogue
Future<bool> emergencyUpdateDialogue(BuildContext context) async {
  ThemesMode().init(context);
  ScreenConfig().init(context);

  return showDialog(
    barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.white54,
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Wrap(children: [
            Container(
              clipBehavior: Clip.none,
              margin: EdgeInsets.all(responsiveWidth(8)),
              padding: EdgeInsets.fromLTRB(responsiveWidth(15), responsiveWidth(10), responsiveWidth(15), responsiveWidth(15)),
              decoration: BoxDecoration(
                  color: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
                  borderRadius: BorderRadius.circular(responsiveWidth(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        blurRadius: responsiveWidth(3),
                        spreadRadius: responsiveWidth(3),
                        offset: Offset.zero)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.android_rounded,
                        size: responsiveHeight(24),
                        //color: Colors.black,
                      ),
                      SizedBox(
                        width: responsiveWidth(10),
                      ),
                      Text(
                        'Emergency Update',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: fontAudioWide,
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveText(20),
                          decoration: TextDecoration.none,
                          color: ThemesMode.isDarkMode?textWhite:textBlack,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: responsiveHeight(10),
                  ),
                  Text(
                    'Please update the app to continue.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: responsiveText(16),
                      //fontFamily: null,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      color: ThemesMode.isDarkMode?textWhite:textBlack,
                    ),
                  ),
                  SizedBox(
                    height: responsiveHeight(20),
                  ),
                  SizedBox(
                    height: responsiveHeight(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Spacer(),
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () async{
                              if (await canLaunch(appLink)) {
                              await launch(appLink);
                              } else {
                              throw 'Could not launch $appLink';
                              }
                            },
                            padding: EdgeInsets.zero,
                            color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: (8), right: 8),
                              child: Text(
                                'Update Now',
                                style: TextStyle(
                                  fontSize: responsiveText(16),
                                  //fontFamily: null,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                  color: ThemesMode.isDarkMode?textWhite:textBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    },
  );

}

//App Update Dialogue
Future<bool> appUpdateDialogue(BuildContext context) async {
  ThemesMode().init(context);
  ScreenConfig().init(context);

  return showDialog(
    barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.white54,
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Wrap(children: [
            Container(
              clipBehavior: Clip.none,
              margin: EdgeInsets.all(responsiveWidth(8)),
              padding: EdgeInsets.fromLTRB(responsiveWidth(15), responsiveWidth(10), responsiveWidth(15), responsiveWidth(15)),
              decoration: BoxDecoration(
                  color: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
                  borderRadius: BorderRadius.circular(responsiveWidth(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        blurRadius: responsiveWidth(3),
                        spreadRadius: responsiveWidth(3),
                        offset: Offset.zero)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.android_rounded,
                        size: responsiveHeight(24),
                        //color: Colors.black,
                      ),
                      SizedBox(
                        width: responsiveWidth(10),
                      ),
                      Text(
                        'Update Available',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: fontAudioWide,
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveText(20),
                          decoration: TextDecoration.none,
                          color: ThemesMode.isDarkMode?textWhite:textBlack,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: responsiveHeight(10),
                  ),
                  Text(
                    'A newer version of the app is available.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: responsiveText(16),
                      //fontFamily: null,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      color: ThemesMode.isDarkMode?textWhite:textBlack,
                    ),
                  ),
                  SizedBox(
                    height: responsiveHeight(20),
                  ),
                  SizedBox(
                    height: responsiveHeight(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () async{
                              if (await canLaunch(appLink)) {
                                await launch(appLink);
                              } else {
                                throw 'Could not launch $appLink';
                              }
                            },
                            padding: EdgeInsets.zero,
                            color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                'Update Now',
                                style: TextStyle(
                                  fontSize: responsiveText(16),
                                  //fontFamily: null,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                  color: ThemesMode.isDarkMode?textBlue.withOpacity(0.7):textBlue.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: responsiveWidth(15),
                        ),
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            padding: EdgeInsets.zero,
                            color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                'Later',
                                style: TextStyle(
                                  fontSize: responsiveText(16),
                                  //fontFamily: null,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                  color: ThemesMode.isDarkMode?textOrange.withOpacity(0.7):textRed.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    },
  );
}

//Theme Choice Dialogue
Future<bool> themeChoiceDialogue(BuildContext context) async {
  ThemesMode().init(context);
  ScreenConfig().init(context);

  List theme = themes;

  void onThemeChanged(String value) async {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    var prefs = await SharedPreferences.getInstance();
    if (value == systemDefault) {
      themeNotifier .setThemeMode(ThemeMode.system);
    } else if (value == dark) {
      themeNotifier.setThemeMode(ThemeMode.dark);
    } else {
      themeNotifier.setThemeMode(ThemeMode.light);
    }
    prefs.setString(appTheme, value);
    Navigator.pop(context);
  }

  return showDialog(
    barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.white54,
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Center(
        child: Wrap(children: [
          Container(
            clipBehavior: Clip.none,
            margin: EdgeInsets.all(responsiveWidth(8)),
            padding: EdgeInsets.fromLTRB(responsiveWidth(15), responsiveWidth(10), responsiveWidth(15), responsiveWidth(15)),
            decoration: BoxDecoration(
                color: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
                borderRadius: BorderRadius.circular(responsiveWidth(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      blurRadius: responsiveWidth(1),
                      spreadRadius: responsiveWidth(1),
                      offset: Offset.zero)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.color_lens,
                      size: responsiveHeight(24),
                      color: textRed,
                    ),
                    SizedBox(
                      width: responsiveWidth(10),
                    ),
                    Text(
                      'Choose Themes',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: fontAudioWide,
                        fontSize: responsiveText(20),
                        decoration: TextDecoration.none,
                        color: ThemesMode.isDarkMode?textWhite:textBlack,
                      ),
                    ),
                  ],
                ),
                // Divider(
                //   thickness: 1,
                // ),
                SizedBox(
                  height: responsiveHeight(10),
                ),
                SizedBox(
                  height: responsiveHeight(100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Expanded(
                        child: Tooltip(
                          message: 'Day',
                          child: CupertinoButton(
                            onPressed: () async{
                              onThemeChanged(theme[1]);
                            },
                            padding: EdgeInsets.zero,
                            color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Icon(
                                Icons.wb_sunny,
                                color: textAmber,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: responsiveWidth(15),
                      ),
                      Expanded(
                        child: Tooltip(
                          message: 'Night',
                          child: CupertinoButton(
                            onPressed: () async{
                              onThemeChanged(theme[2]);
                            },
                            padding: EdgeInsets.zero,
                            color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Icon(
                                Icons.nightlight_round,
                                color: textMaroon,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: responsiveWidth(15),
                      ),
                      Expanded(
                        child: Tooltip(
                          message: 'System Default',
                          child: CupertinoButton(
                            onPressed: () async{
                              onThemeChanged(theme[0]);
                            },
                            padding: EdgeInsets.zero,
                            color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Icon(
                                Icons.android,
                                color: textGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    },
  );
}
