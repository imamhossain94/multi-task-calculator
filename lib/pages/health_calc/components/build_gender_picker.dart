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
            height: responsiveHeight(120),
            width: responsiveWidth(55),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(active ? 0.3 : 0.05),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  size: responsiveHeight(56),
                ),
                Text(title, style:
                  TextStyle(
                    fontSize: responsiveHeight(24),
                    fontWeight: FontWeight.bold
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
