import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';

class BuildDrawerBodyItem extends StatelessWidget {
  const BuildDrawerBodyItem({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return ListTile(
      title: Row(
        children: <Widget>[
          icon,
          Padding(
            padding: EdgeInsets.only(left: responsiveWidth(8.0)),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
