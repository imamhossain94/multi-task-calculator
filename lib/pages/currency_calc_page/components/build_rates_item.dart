import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildRateItem extends StatelessWidget {
  BuildRateItem({
    @required this.hint,
    @required  this.inputType,
    @required this.textController
  });

  final String hint;
  final TextInputType inputType;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    ScreenConfig().init(context);

    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: ThemesMode.isDarkMode?Colors.black:backgroundLight,
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
      child: Container(
        margin: EdgeInsets.all(5),
        height: responsiveHeight(40),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            prefix: SizedBox(
              width: 5,
            ),
            border: InputBorder.none,
            hintText: hint,
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          autocorrect: false,
          obscureText: false,
        ),
      ),
    );
  }
}
