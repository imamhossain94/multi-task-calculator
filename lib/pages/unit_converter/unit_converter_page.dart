import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/pages/unit_converter/components/build_unit_converter_menu_pad.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class UnitConverterPage extends StatefulWidget {
  @override
  _UnitConverterPageState createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {

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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Unit Converter',
            style: TextStyle(
                //color: Colors.black,
                fontFamily: fontAudioWide,
                fontSize: responsiveText(18)),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    BuildUnitConverterMenuPad()
                  ],
                )
            ),
            BuildBannerAd(width: ScreenConfig.screenWidth, height: 50,),
          ],
        ),
      ),
    );
  }
}
