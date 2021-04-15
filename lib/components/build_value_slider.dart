import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildValueSlider extends StatefulWidget {
  final String title;
  final double max, min, value;
  final ValueChanged<double> rate;
  final bool numberResult;
  const BuildValueSlider({
    @required this.title,
    @required this.min,
    @required this.max,
    @required this.rate,
    @required this.numberResult,
    @required this.value,
  });

  @override
  _BuildValueSliderState createState() => _BuildValueSliderState();
}

class _BuildValueSliderState extends State<BuildValueSlider> {
  double _value;

  @override
  void initState(){
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: responsiveText(16), fontWeight: FontWeight.bold),
              ),
              Spacer(),
              //BuildHelpButton(toolTipKey: GlobalKey(), symbol: '%', message: 'US dollar sign', color: Colors.black54,),
            ],
          ),
          Container(
            height: responsiveHeight(40),
            margin: EdgeInsets.only(top: responsiveHeight(8), bottom: responsiveHeight(5)),
            padding: EdgeInsets.only(left: responsiveWidth(20)),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Text(
                  widget.numberResult || _value == 0 || _value == 100 ?'${_value.toInt()}':
                  '${_value.toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: responsiveText(16)),
                ),
                Expanded(
                  child: Slider(
                    max: widget.max,
                    min: widget.min,
                    value: _value,
                    activeColor: Colors.black87,
                    inactiveColor: Colors.black38,
                    onChanged: (double newValue) {
                      setState(() {
                        _value = newValue;
                      });
                      widget.rate(_value);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
