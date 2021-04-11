import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildAppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          appIconLight,
          height: responsiveHeight(55),
          width: responsiveHeight(55),
        ),
        SizedBox(
          width: responsiveWidth(10),
        ),
        Text(
          appNameNewLine,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: fontAudioWide,
            fontSize: responsiveText(24),
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
