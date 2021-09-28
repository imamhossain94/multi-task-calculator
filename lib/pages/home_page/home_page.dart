import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/components/build_pop_up_munu_item.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_app_drawer.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_home_menu_pad.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_popup_menu_button.dart';
import 'package:multi_task_calculator/services/shared_pref_services.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  Timer _timer;
  //int rewardTime = 21600; //21600 second 360 minute or 6h
  //int rewardTime = 14400; //14400 second 240 minute or 4h
  int rewardSeconds; //120 second 2 minute ; uncomment for test


  @override
  void initState() {
    createTimer();
    super.initState();
  }

  @override
  void dispose() {
    if(_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  void createTimer() async{
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t)=>
        setState((){
          if(getAdFreeTime() != 'zero'){
            DateTime x = DateTime.now(), y = DateTime.tryParse(getAdFreeTime());
            int seconds = x.difference(y).inSeconds;
            rewardSeconds = seconds;
            if(seconds >= rewardTime){
              t.cancel();
              rewardSeconds = null;
              setAdFreeTime('zero');
              setAppPurchasedStatus(false);
            }
          }else{
            //rewardSeconds = null;
            setAdFreeTime('zero');
            setAppPurchasedStatus(false);
            t.cancel();
          }
        })
    );
  }



  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    ScreenConfig().init(context);

    createTimer();

    return WillPopScope(
      onWillPop: () async {
        if (_key.currentState.isDrawerOpen) {
          Navigator.of(context).pop();
          return false;
        } else {
          return await onBackPressed(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: _key,
          //backgroundColor: Colors.white,
          drawerScrimColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(CupertinoIcons.bars,
                      size: responsiveHeight(35)), // change this size and style
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Text(
              appName,
              style: TextStyle(
                  //color: Colors.black,
                  fontFamily: fontAudioWide,
                  fontSize: responsiveText(18)),
            ),
            actions: [
              //BuildPopupMenuButton(),
              IconButton(
                  onPressed: () {
                    Share.share('Hey check out this android app $appLink');
                  },
                  icon: FaIcon(FontAwesomeIcons.shareAlt)
              )
            ],
          ),
          drawer: BuildAppDrawer(),
          body: Column(
            children: [
              Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      BuildHomeMenuPad()
                    ],
                  )
              ),
              rewardSeconds != null?
                  Container(
                    height: 50,
                    width: ScreenConfig.screenWidth,
                    alignment: Alignment.center,
                    color: Colors.black12,
                    child: Text(
                        '${(rewardTime-rewardSeconds)~/60}m ${(rewardTime-rewardSeconds)%60}s'
                    ),
                  ):
              BuildBannerAd(),
            ],
          ),
        ),
      ),
    );
  }

}

