import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_pop_up_munu_item.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_app_drawer.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_home_menu_pad.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_popup_menu_button.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    ScreenConfig().init(context);

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
              BuildPopupMenuButton(),
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
              Container(
                height: 60,
                color: Colors.black12,
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: ThemesMode.isDarkMode ? textWhite : textBlack,
          //   foregroundColor: ThemesMode.isDarkMode ? textOrange : Colors.yellow,
          //   tooltip: 'Rate The App',
          //   onPressed: () {},
          //   child: Icon(Icons.star),
          // ),
        ),
      ),
    );
  }
}
