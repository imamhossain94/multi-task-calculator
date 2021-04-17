import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildSavingsValuePicker extends StatelessWidget {
  final String title, frequencyName;
  final VoidCallback onPressedAction;

  const BuildSavingsValuePicker({
    @required this.title,
    @required this.frequencyName,
    @required this.onPressedAction,
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
                style: TextStyle(
                    fontSize: responsiveText(16), fontWeight: FontWeight.bold),
              ),
              //Spacer(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: responsiveHeight(8), bottom: responsiveHeight(5)),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        //margin: EdgeInsets.only(top: responsiveHeight(8), bottom: responsiveHeight(5)),
                        height: 40,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: onPressedAction,
                            child: Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  frequencyName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                        ))),
                SizedBox(
                  width: responsiveWidth(10),
                ),
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
                      child: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 30,
                      ),
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
