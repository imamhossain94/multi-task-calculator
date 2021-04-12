import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildHomeMenuButton extends StatelessWidget {
  BuildHomeMenuButton({
    @required this.icon,
    @required this.title,
    @required this.color,
    @required this.onPressed
  });
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    ScreenConfig().init(context);
    ThemesMode().init(context);
    double size = (ScreenConfig.screenWidth-40) / 3;

    return Container(
        width: size,
        height: size,
        margin: EdgeInsets.all(5),
        //padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: ThemesMode.isDarkMode?Colors.black87:Colors.white,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: onPressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 35,
                    color: color,
                  ),
                  //SizedBox(height: responsiveHeight(10),),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
          ),
        )
    );

  }
}