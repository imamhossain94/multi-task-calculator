import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 2,
            title: Text(
              'Feedback',
              style: TextStyle(
                  fontSize: responsiveText(22),
                  fontFamily: 'Audiowide',),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(responsiveWidth(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '◑︵◐',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: responsiveText(60), ),
                ),
                Text(
                  'Your rating is too low. '
                  'Please let us know how we can improve this app to meet your need.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: responsiveText(18),),
                ),
                CupertinoButton(
                  color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
                  onPressed: () async {
                    if (await canLaunch(feedbackMail)) {
                      await launch(feedbackMail);
                    } else {
                      throw 'Could not launch $feedbackMail';
                    }
                  },
                  child: Text('Send Mail', style: TextStyle(
                    color: ThemesMode.isDarkMode?textYellow:textBlack,
                  ),),
                )
              ],
            ),
          )),
    );
  }
}
