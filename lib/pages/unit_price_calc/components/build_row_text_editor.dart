import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';


class BuildRowTextEditor extends StatelessWidget {
  const BuildRowTextEditor({
    Key key,
    @required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {

    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
            controller: textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0',
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            autocorrect: false,
            obscureText: false,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

