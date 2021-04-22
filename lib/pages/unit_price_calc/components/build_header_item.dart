import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildHeaderItem extends StatelessWidget {
  const BuildHeaderItem({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {

    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Expanded(
      child: Container(
          margin: EdgeInsets.all(5),
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
