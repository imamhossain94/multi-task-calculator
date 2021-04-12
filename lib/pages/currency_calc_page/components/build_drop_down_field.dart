import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildDropDownField extends StatelessWidget {
  BuildDropDownField({
    @required this.title,
    @required  this.value,
    @required this.onPressed
  });
  final String title, value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    ScreenConfig().init(context);

    return Container(
      width: ScreenConfig.screenWidth/2-30,
      height: responsiveHeight(40),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: ThemesMode.isDarkMode?Colors.black87:Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.grey.withOpacity(0.2),
          //       blurRadius: 0.5,
          //       spreadRadius: 0.5,
          //       offset: Offset.zero
          //   )
          // ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Text(value, style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: responsiveWidth(5),),
                Icon(Icons.arrow_drop_down_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
