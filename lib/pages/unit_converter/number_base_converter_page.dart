import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/pages/unit_converter/components/build_unit_text_field.dart';
import 'package:multi_task_calculator/pages/unit_converter/models/unit_converter_helper.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:units_converter/units_converter.dart';

class NumberBaseConverterPage extends StatefulWidget {
  @override
  _NumberBaseConverterPageState createState() => _NumberBaseConverterPageState();
}

class _NumberBaseConverterPageState extends State<NumberBaseConverterPage> {

  TextEditingController fromUnitController = TextEditingController();
  TextEditingController toUnitController = TextEditingController();

  Map<String, dynamic> allUnits;
  dynamic fromUnit, toUnit;
  String fromUnitDisplay, removeString;
  bool isLoading = true;

  List<UnitConversion> unitConversionList = [];
  String fromUnitValue;

  GoogleAdService _googleAdService = GoogleAdService();

  @override
  void initState() {
    _googleAdService.initAd();
    fromUnitValue = '0';
    fromUnitController.text = '0';
    toUnitController.text = '0';
    getAllUnit();
    fromUnitController.addListener((){
      setState(() {
        fromUnitValue = fromUnitController.value.text;
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


  void getAllUnit() async{
    setState(() {
      isLoading = true;
      unitConversionList.clear();
    });
    setState(() {

      removeString = 'NUMERAL_SYSTEMS.';
      var numeralSystems = NumeralSystems();

      allUnits = NumberBaseUnitsList;
      fromUnit = fromUnit == null? allUnits.entries.elementAt(0).value:fromUnit;
      toUnit = toUnit == null? allUnits.entries.elementAt(1).value.toString().replaceAll(removeString, ''):toUnit.toString().replaceAll(removeString, '');
      fromUnitDisplay = fromUnit.toString().replaceAll(removeString, '');
      numeralSystems.convert(fromUnit, fromUnitValue);

      unitConversionList.add(UnitConversion(unitName: numeralSystems.decimal.name.toString().replaceAll(removeString, ''), unitCode: numeralSystems.decimal.symbol, unitValue: numeralSystems.decimal.stringValue));
      unitConversionList.add(UnitConversion(unitName: numeralSystems.hexadecimal.name.toString().replaceAll(removeString, ''), unitCode: numeralSystems.hexadecimal.symbol, unitValue: numeralSystems.hexadecimal.stringValue));
      unitConversionList.add(UnitConversion(unitName: numeralSystems.octal.name.toString().replaceAll(removeString, ''), unitCode: numeralSystems.octal.symbol, unitValue: numeralSystems.octal.stringValue));
      unitConversionList.add(UnitConversion(unitName: numeralSystems.binary.name.toString().replaceAll(removeString, ''), unitCode: numeralSystems.binary.symbol, unitValue: numeralSystems.binary.stringValue));

      unitConversionList.forEach((obj) {
        if(obj.unitName == toUnit.toString()){
          toUnitController.text = obj.unitValue.toString()??'fuck';
        }
      });

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
          title: Text('Number Base',
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                await _googleAdService.showInterstitialAd();
                resetPage(context, numberBaseConverterPage);
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
                    hint: '0',
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

                                      //${currencyRates[index].symbol}

                                      Expanded(
                                        child: Text(unitConversionList[index].unitValue.toString(),
                                            textAlign: TextAlign.right,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      ),
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
            BuildBannerAd(width: ScreenConfig.screenWidth, height: 50,),
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
