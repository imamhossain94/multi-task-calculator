import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_home_menu_button.dart';
import 'package:multi_task_calculator/pages/unit_converter/models/unit_converter_helper.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/utils/constant.dart';

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
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.angleUnit),
            color: textMaroon,
          ),
          BuildHomeMenuButton(
            title: 'Area',
            icon: FontAwesomeIcons.chartArea,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.areaUnit),
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Energy',
            icon: FontAwesomeIcons.chargingStation,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.energyUnit),
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Force',
            icon: FontAwesomeIcons.rocket,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.forceUnit),
            color: textMaroon,
          ),
          BuildHomeMenuButton(
            title: 'Length',
            icon: FontAwesomeIcons.rulerHorizontal,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.lengthUnit),
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Speed',
            icon: FontAwesomeIcons.meteor,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.speedUnit),
            color: textOrange,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Power',
            icon: FontAwesomeIcons.powerOff,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.powerUnit),
            color: textYellow,
          ),
          BuildHomeMenuButton(
            title: 'Pressure',
            icon: FontAwesomeIcons.tachometerAlt,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.pressureUnit),
            color: textMaroon,
          ),
          BuildHomeMenuButton(
            title: 'Shoe Size',
            icon: FontAwesomeIcons.shoePrints,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.shoeSizeUnit),
            color: Colors.cyan,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Temperature',
            icon: FontAwesomeIcons.thermometerThreeQuarters,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.temperatureUnit),
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Storage',
            icon: FontAwesomeIcons.memory,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.storageUnit),
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Weight',
            icon: FontAwesomeIcons.weight,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.weightUnit),
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Time',
            icon: FontAwesomeIcons.hourglassHalf,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.timeUnit),
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Volume',
            icon: FontAwesomeIcons.cube,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.weightUnit),
            color: textMaroon,
          ),
          BuildHomeMenuButton(
            title: 'Fuel Consumption',
            icon: FontAwesomeIcons.oilCan,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.weightUnit),
            color: textBlue,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Torque',
            icon: FontAwesomeIcons.tumblr,
            onPressed: ()=>changePage(context: context, selectedUnit: UnitConversionHelper.torqueUnit),
            color: textAmber,
          ),
          BuildHomeMenuButton(
            title: 'Number Base',
            icon: FontAwesomeIcons.sortNumericUp,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, numberBaseConverterPage);
            },
            color: textMaroon,
          ),
        ]),
      ]),
    );
  }

  void changePage({BuildContext context, var selectedUnit}) async{
    await showInterstitialAd();
    Navigator.pushNamed(context, unitConverterChildPage, arguments: {
      'selectedUnit': selectedUnit,
    });
  }


}



