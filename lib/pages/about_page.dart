import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_task_calculator/components/build_app_logo.dart';
import 'package:multi_task_calculator/services/shared_pref_services.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.5,
            title: Text(
              'About',
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
                  flex: responsiveHeight(5).toInt(),
                  child: BuildAppLogo()
                ),
                Expanded(
                  flex: responsiveHeight(5).toInt(),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildHeader('Development'),
                        buildDescription('Android Engineering', developerName),
                        buildDescription('UI Design', designerName),
                        buildDescription('Icon Used', 'flaticon, fontawesome'),
                        buildHeaderClickable('Other App', () async{
                          if (await canLaunch(storeLink)) {
                            await launch(storeLink);
                          } else {
                            throw 'Could not launch $storeLink';
                          }
                        }),
                        SizedBox(height: responsiveHeight(8),),

                        buildHeaderClickable('$appName: ${getAppVersion()}', () async{

                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }



  Container buildHeader(String title) {
    return Container(
      height: responsiveHeight(50),
      color: Colors.grey.withOpacity(0.12),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: responsiveText(18), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildHeaderClickable(String title, VoidCallback onPressed) {
    return Material(
      child: new InkWell(
        onTap: () {
          onPressed();
          //print("tapped");
        },
        child: Container(
          height: responsiveHeight(50),
          color: Colors.grey.withOpacity(0.12),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: responsiveText(18), fontWeight: FontWeight.bold),
          ),
        )
      ),
    );
  }

  Widget buildDescription(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          text: '$title: ',
          style: TextStyle(
              fontSize: responsiveText(14),
              fontWeight: FontWeight.bold,
              color: ThemesMode.isDarkMode?textWhite:textBlack
          ),
          children: <TextSpan>[
            new TextSpan(
                text: description,
                style: TextStyle(
                    fontSize: responsiveText(14),
                    fontWeight: FontWeight.normal,
                    color: ThemesMode.isDarkMode?textWhite:textBlack
                )),
          ],
        ),
      ),
    );
  }
}
