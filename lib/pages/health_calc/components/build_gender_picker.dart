import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildGenderPicker extends StatefulWidget {
  final String title;
  final ValueChanged<String> valueChanged;

  BuildGenderPicker({
    @required this.title,
    @required this.valueChanged,
  });

  @override
  _BuildGenderPickerState createState() => _BuildGenderPickerState();
}

class _BuildGenderPickerState extends State<BuildGenderPicker> {
  bool isMale, isFemale;

  @override
  void initState() {
    isMale = true;
    isFemale = false;
    super.initState();
  }

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
                widget.title,
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
                buildGenderButton(
                  title: 'Male',
                  icon: FontAwesomeIcons.mars,
                  onPressed: (){
                    setState(() {
                      isMale = true;
                      isFemale = false;
                    });
                    widget.valueChanged('Male');
                  },
                  active:isMale,
                ),
                SizedBox(
                  width: responsiveWidth(10),
                ),
                buildGenderButton(
                  title: 'Female',
                  icon: FontAwesomeIcons.venus,
                  onPressed: (){
                    setState(() {
                      isMale = false;
                      isFemale = true;
                    });
                    widget.valueChanged('Female');
                  },
                  active:isFemale,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded buildGenderButton({String title, IconData icon, VoidCallback onPressed, bool active}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onPressed,
          child: Container(
            //height: responsiveHeight(120),
            width: responsiveWidth(55),
            padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ThemesMode.isDarkMode?Colors.grey.withOpacity(active ? 0.3 : 0.15):Colors.grey.withOpacity(active ? 0.3 : 0.07),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: responsiveHeight(26),
                ),
                Expanded(
                  child: Text(title, textAlign: TextAlign.center, style:
                    TextStyle(
                      fontSize: responsiveHeight(18),
                      fontWeight: FontWeight.bold
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
