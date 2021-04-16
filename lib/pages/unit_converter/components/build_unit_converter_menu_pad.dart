import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_home_menu_button.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:unit_convert/unit_convert.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildUnitConverterMenuPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Angle',
            icon:FontAwesomeIcons.superpowers,
            onPressed: () {
              Navigator.pushNamed(context, unitConverterChildPage);
            },
            color: textRed,
          ),
          BuildHomeMenuButton(
            title: 'Area',
            icon: FontAwesomeIcons.chartArea,
            onPressed: () {

            },
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Energy',
            icon: FontAwesomeIcons.chargingStation,
            onPressed: ()=> {},
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Force',
            icon: FontAwesomeIcons.rocket,
            onPressed: ()=> {},
            color: textRed,
          ),
          BuildHomeMenuButton(
            title: 'Length',
            icon: FontAwesomeIcons.rulerHorizontal,
            onPressed: ()=> {},
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Number',
            icon: FontAwesomeIcons.sortNumericUp,
            onPressed: ()=> {},
            color: textMaroon,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Power',
            icon: FontAwesomeIcons.powerOff,
            onPressed: ()=> {},
            color: textYellow,
          ),
          BuildHomeMenuButton(
            title: 'Pressure',
            icon: FontAwesomeIcons.tachometerAlt,
            onPressed: ()=> {},
            color: textRed,
          ),
          BuildHomeMenuButton(
            title: 'Speed',
            icon: FontAwesomeIcons.meteor,
            onPressed: ()=> {},
            color: textOrange,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Temperature',
            icon: FontAwesomeIcons.thermometerThreeQuarters,
            onPressed: ()=> {},
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Storage',
            icon: FontAwesomeIcons.memory,
            onPressed: ()=> {},
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Weight',
            icon: FontAwesomeIcons.weight,
            onPressed: ()=> {},
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Time',
            icon: FontAwesomeIcons.hourglassHalf,
            onPressed: ()=> {},
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Volume',
            icon: FontAwesomeIcons.cube,
            onPressed: ()=> {},
            color: textMaroon,
          ),

        ]),
      ]),
    );
  }
}



