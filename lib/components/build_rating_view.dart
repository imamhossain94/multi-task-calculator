import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:url_launcher/url_launcher.dart';


class BuildRatingValue extends StatelessWidget {
  final int value;
  final Color color;
  const BuildRatingValue({Key key, this.value, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        onPressed: () async {
          if (value <= 3) {
            Navigator.pop(context);
            Navigator.pushNamed(context, feedbackPage);
          } else if (value <= 5) {
            Navigator.pop(context);
            if (await canLaunch(appLink)) {
              await launch(appLink);
            } else {
              throw 'Could not launch $appLink';
            }
          }
        },
        padding: EdgeInsets.zero,
        color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
              value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
