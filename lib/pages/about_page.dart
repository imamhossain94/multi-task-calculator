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
  List<String> features;


  Map<int, int> widgetFlax(){
    int len = features.length;
    if(len == 1){
      return {1: 14, 2:11};
    }else if(len == 2){
      return {1: 12, 2:11};
    }else if(len == 4){
      return {1: 11, 2:13};
    }else if(len == 5){
      return {1: 12, 2:16};
    }else if(len == 6){
      return {1: 12, 2:18};
    }else{
      return {1: 1, 2:1};
    }
  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);
    features = appFeature;

    return SafeArea(
      child: Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 2,
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
                  flex: responsiveHeight((widgetFlax()[1]).toDouble()).toInt(),
                  child: BuildAppLogo()
                ),
                Expanded(
                  flex: responsiveHeight((widgetFlax()[2]).toDouble()).toInt(),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildHeader('Feature'),
                        Container(
                          padding: EdgeInsets.fromLTRB(responsiveWidth(30), responsiveWidth(10), responsiveWidth(30), responsiveWidth(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: buildFeatureList(),
                          ),
                        ),
                        buildHeader('Development'),
                        buildDescription('Android Engineering', developerName),
                        buildDescription('UI Design', designerName),
                        buildHeaderClickable('Other App', () async{
                          if (await canLaunch(storeLink)) {
                            await launch(storeLink);
                          } else {
                            throw 'Could not launch $storeLink';
                          }
                        }),
                        SizedBox(height: responsiveHeight(8),),
                        buildHeaderClickable('$appName: ${getAppVersion()}', () async{
                          if (await canLaunch(appLink)) {
                            await launch(appLink);
                          } else {
                            throw 'Could not launch $appLink';
                          }
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


  List<Widget> buildFeatureList() {
    return features.map((feature) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          feature,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: responsiveText(14)),
        ),
      );
    }).toList();
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
