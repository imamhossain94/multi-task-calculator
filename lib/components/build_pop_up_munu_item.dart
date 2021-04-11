import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';

class BuildPopUpMenuItem extends StatelessWidget {
  const BuildPopUpMenuItem({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Row(
      children: <Widget>[
        icon,
        Padding(
          padding: EdgeInsets.only(left: responsiveWidth(8.0)),
          child: Text(text),
        )
      ],
    );
  }
}
