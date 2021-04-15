import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildResultCard extends StatelessWidget {
  final String title, value;

  const BuildResultCard({
    @required this.title,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ThemesMode.isDarkMode?Colors.black:textWhite,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset.zero
              )
            ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: responsiveText(26), fontWeight: FontWeight.bold),
            ),

            Divider(),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: responsiveText(14), fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
    );

  }
}
