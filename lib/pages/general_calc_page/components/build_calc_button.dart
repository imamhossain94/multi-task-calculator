import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildCalcButton extends StatelessWidget {
  BuildCalcButton({
    @required this.title,
    @required this.onPressed,
    this.buttonColor,
    this.textColor
  });
  final String title;
  final Color buttonColor, textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: buttonColor==null?ThemesMode.isDarkMode?Colors.black87:Colors.white:buttonColor,
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
          child: Tooltip(
            message: symbolName(title),
            child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: onPressed,
                child: Padding(
                  padding: EdgeInsets.only(top: responsiveHeight(15), bottom: responsiveHeight(15)),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: title == '\u232b'?responsiveText(18):title == '\u22ef'?responsiveText(17.5):responsiveText(22),
                        fontWeight: FontWeight.bold,
                        color: textColor==null?ThemesMode.isDarkMode?textWhite:textBlack:textColor,
                    ),
                  ),
                ),
            ),
          ),
        )
    );
  }

  String symbolName(String symbol){
    if(symbol == '\u232b'){
      return 'Delete';
    }else if(symbol == '\u22ef'){
      return 'More';
    }else if(symbol == '('){
      return 'Left Bracket';
    }else if(symbol == ')'){
      return 'Right Bracket';
    }else if(symbol == 'C'){
      return 'Clear';
    }else if(symbol == '%'){
      return 'Percent';
    }else if(symbol == 'x\u207f'){
      return 'Power of n';
    }else if(symbol == '.'){
      return 'Decimal Point';
    }else if(symbol == '='){
      return 'Equal';
    }else if(symbol == '+'){
      return 'Addition';
    }else if(symbol == '–'){
      return 'Subtraction';
    }else if(symbol == '÷'){
      return 'Division';
    }else if(symbol == '×'){
      return 'Multiplication';
    }else{
      return symbol;
    }
  }

}