import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/pages/unit_converter/components/build_unit_text_field.dart';
import 'package:multi_task_calculator/pages/unit_converter/models/unit_converter_helper.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:units_converter/units_converter.dart';
//import 'package:unit_convert/unit_convert.dart';

class UnitConverterChildPage extends StatefulWidget {
  // final String selectedUnit;
  // const UnitConverterChildPage({Key key, this.selectedUnit}) : super(key: key);

  final arguments;
  const UnitConverterChildPage({this.arguments});

  @override
  _UnitConverterChildPageState createState() => _UnitConverterChildPageState();
}

class _UnitConverterChildPageState extends State<UnitConverterChildPage> {

  TextEditingController fromUnitController = TextEditingController();
  TextEditingController toUnitController = TextEditingController();

  var unitObj;
  Map<String, dynamic> allUnits;
  dynamic fromUnit, toUnit;
  String fromUnitDisplay, removeString, selectedUnit;
  bool isLoading = true;

  List<UnitConversion> unitConversionList = [];
  double fromUnitValue;

  @override
  void initState() {
    selectedUnit = widget.arguments['selectedUnit'];
    fromUnitValue = 0.0;
    fromUnitController.text = '0.0';
    toUnitController.text = '0.0';
    getAllUnit();
    fromUnitController.addListener((){
      setState(() {
        String  fromCurrencyValue = fromUnitController.value.text;
        fromUnitValue = double.tryParse(fromCurrencyValue)??0.0;
        getAllUnit();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    fromUnitController.dispose();
    toUnitController.dispose();
    super.dispose();
  }


  void updateResult() {
    fromUnit = fromUnit == null? allUnits.entries.elementAt(0).value:fromUnit;
    toUnit = toUnit == null? allUnits.entries.elementAt(1).value.toString().replaceAll(removeString, ''):toUnit.toString().replaceAll(removeString, '');
    fromUnitDisplay = fromUnit.toString().replaceAll(removeString, '');
    unitObj.convert(fromUnit, fromUnitValue);
    var units = unitObj.getAll();
    for (var unit in units) {
      //if(unit.name != null &&  unit.symbol != null){
        unitConversionList.add(UnitConversion(unitName: unit.name.toString().replaceAll(removeString, ''), unitCode: unit.symbol??unit.name.toString().replaceAll(removeString, ''), unitValue: unit.value));
      //}
    }
    unitConversionList.forEach((obj) {
      print(obj.unitName);
      if(obj.unitName == toUnit.toString()){
        toUnitController.text = obj.unitValue.toStringAsFixed(2);
      }
    });
  }

  void getAllUnit() async{
    setState(() {
      isLoading = true;
      unitConversionList.clear();
    });
    setState(() {
      if(selectedUnit == UnitConversionHelper.angleUnit){
        removeString = 'ANGLE.';
        unitObj = Angle(significantFigures: 7, removeTrailingZeros: false);
        allUnits = AngleUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.areaUnit){
        removeString = 'AREA.';
        unitObj = Area(significantFigures: 7, removeTrailingZeros: false);
        allUnits = AreaUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.energyUnit){
        removeString = 'ENERGY.';
        unitObj = Energy(significantFigures: 7, removeTrailingZeros: false);
        allUnits = EnergyUnitsList;
        updateResult();
      } else if(selectedUnit == UnitConversionHelper.forceUnit){
        removeString = 'FORCE.';
        unitObj = Force(significantFigures: 7, removeTrailingZeros: false);
        allUnits = ForceUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.lengthUnit){
        removeString = 'LENGTH.';
        unitObj = Length(significantFigures: 7, removeTrailingZeros: false);
        allUnits = LengthUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.powerUnit){
        removeString = 'POWER.';
        unitObj = Power(significantFigures: 7, removeTrailingZeros: false);
        allUnits = PowerUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.pressureUnit){
        removeString = 'PRESSURE.';
        unitObj = Pressure(significantFigures: 7, removeTrailingZeros: false);
        allUnits = PressureUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.speedUnit){
        removeString = 'SPEED.';
        unitObj = Speed(significantFigures: 7, removeTrailingZeros: false);
        allUnits = SpeedUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.storageUnit){
        removeString = 'DIGITAL_DATA.';
        unitObj = DigitalData(significantFigures: 7, removeTrailingZeros: false);
        allUnits = StorageUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.temperatureUnit){
        removeString = 'TEMPERATURE.';
        unitObj = Temperature(significantFigures: 7, removeTrailingZeros: false);
        allUnits = TemperatureUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.timeUnit){
        removeString = 'TIME.';
        unitObj = Time(significantFigures: 7, removeTrailingZeros: false);
        allUnits = TimeUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.volumeUnit){
        removeString = 'VOLUME.';
        unitObj = Volume(significantFigures: 7, removeTrailingZeros: false);
        allUnits = VolumeUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.weightUnit){
        removeString = 'MASS.';
        unitObj = Mass(significantFigures: 7, removeTrailingZeros: false);
        allUnits = WeightUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.fuelUnit){
        removeString = 'FUEL_CONSUMPTION.';
        unitObj = FuelConsumption(significantFigures: 7, removeTrailingZeros: false);
        allUnits = FuelUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.torqueUnit){
        removeString = 'TORQUE.';
        unitObj = Torque(significantFigures: 7, removeTrailingZeros: false);
        allUnits = TorqueUnitsList;
        updateResult();
      }else if(selectedUnit == UnitConversionHelper.shoeSizeUnit){
        removeString = 'SHOE_SIZE.';
        unitObj = ShoeSize(significantFigures: 7, removeTrailingZeros: false);
        allUnits = ShoeSizeUnitsList;
        updateResult();
      }

      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(selectedUnit,
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                //await showInterstitialAd();
                Navigator.popAndPushNamed(context, unitConverterChildPage, arguments: {
                  'selectedUnit': selectedUnit,
                });
                //resetPage(context, unitConverterChildPage);
              },
              icon: Icon(Icons.refresh),
              tooltip: 'Reset',
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ThemesMode.isDarkMode?Colors.black:textWhite,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildUnitTextField(
                    isEnabled: true,
                    hint: fromUnitController.text,
                    title: 'From Unit',
                    unitName: fromUnitDisplay,
                    textController: fromUnitController,
                    onPressedAction: () {
                      showUnitPicker(context, (v){
                        FocusScope.of(context).unfocus();
                          setState(() {
                            fromUnit = v;
                            getAllUnit();
                          });
                      });
                    },
                  ),
                  BuildUnitTextField(
                    isEnabled: false,
                    hint: toUnitController.text,
                    title: 'To Unit',
                    unitName: toUnit.toString(),
                    textController: toUnitController,
                    onPressedAction: () {
                      showUnitPicker(context, (v){
                        FocusScope.of(context).unfocus();
                        setState(() {
                          toUnit = v;
                          getAllUnit();
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: ThemesMode.isDarkMode?Colors.black:backgroundLight,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child:isLoading?
                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ThemesMode.isDarkMode?Colors.white12:Colors.black45
                            ),
                          ),
                        ):
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: unitConversionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(unitConversionList[index].unitCode??'', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      //${currencyRates[index].symbol}

                                      Text(unitConversionList[index].unitValue.toStringAsFixed(2),
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text(unitConversionList[index].unitName.toString(),),
                                ],
                              ),
                            );
                          },
                        ),)
                    ],
                  )
              ),
            ),
            //BuildBannerAd(),
          ],
        ),
      ),
    );
  }

  Future<bool>  showUnitPicker(BuildContext context, ValueChanged<dynamic> valueChanged) {
    return showModalBottomSheet(
      context: context,
      elevation: 0.0,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,//ThemesMode.isDarkMode?Colors.black54:Colors.transparent
      builder: (context) {
        return DraggableScrollableSheet(
          // initialChildSize: 0.63,
          // minChildSize: 0.30,
          maxChildSize: 0.97,
          builder: (_, controller) {
            return Container(
              padding: EdgeInsets.only(top: 5,),
              decoration: BoxDecoration(
                  color: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.9),
                        blurRadius: responsiveWidth(3),
                        spreadRadius: responsiveWidth(3),
                        offset: Offset.zero)
                  ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Text('Select Unit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Spacer(),
                        IconButton(icon: Icon(Icons.close), onPressed: (){
                          Navigator.pop(context, false);
                        })
                      ],
                    )
                  ),
                  Expanded(
                    child:
                    ListView.builder(
                      shrinkWrap: true,
                      controller: controller,
                      physics: BouncingScrollPhysics(),
                      itemCount: allUnits.entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          child: InkWell(
                            onTap: (){
                              valueChanged(allUnits.entries.elementAt(index).value);
                              Navigator.pop(context, true);
                            },
                            child:
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(allUnits.entries.elementAt(index).value.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(allUnits.entries.elementAt(index).key.toString(), style: TextStyle()),
                                ],
                              ),
                            )
                          ),
                        );
                      },
                    )
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
