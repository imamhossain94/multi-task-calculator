import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildCurrencyTextField extends StatelessWidget {
  final String title, hint, currencyCode;
  final TextEditingController textController;
  final VoidCallback onPressedAction;
  final bool isEnabled;

  const BuildCurrencyTextField({
    @required this.title,
    @required this.hint,
    @required this.currencyCode,
    @required this.textController,
    @required this.onPressedAction,
    @required this.isEnabled
  });

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Container(
      margin: EdgeInsets.all(responsiveWidth(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: responsiveText(16), fontWeight: FontWeight.bold),
              ),
              //Spacer(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: responsiveHeight(8), bottom: responsiveHeight(5)),
            child: Row(
              children: [
                Container(
                    //margin: EdgeInsets.only(top: responsiveHeight(8), bottom: responsiveHeight(5)),
                    height: 40,
                    width: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(currencyCode, style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                SizedBox(width: responsiveWidth(10),),
                Expanded(child: Container(
                  //margin: EdgeInsets.only(top: responsiveHeight(8), bottom: responsiveHeight(5)),
                  height:40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    enabled: isEnabled,
                    controller: textController,
                    decoration: InputDecoration(
                      prefix: SizedBox(width: responsiveWidth(10),),
                      border: InputBorder.none,
                      hintText: hint,
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                    obscureText: false,
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                )),
                SizedBox(width: responsiveWidth(10),),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onPressedAction,
                    child: Container(
                      height: 40,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.arrow_drop_down_rounded, size: 30,),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
