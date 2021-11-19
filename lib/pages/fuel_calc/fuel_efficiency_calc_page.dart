import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/components/build_result_card.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';


class FuelEfficiencyCalcPage extends StatefulWidget {
  @override
  _FuelEfficiencyCalcPageState createState() => _FuelEfficiencyCalcPageState();
}

class _FuelEfficiencyCalcPageState extends State<FuelEfficiencyCalcPage> {


  TextEditingController mileageBeforeController = TextEditingController();
  TextEditingController refuelledGasolineController = TextEditingController();
  TextEditingController mileageAfterController = TextEditingController();

  String mileageBefore, refuelledGasoline, mileageAfter;
  double calculatedFuelEfficiency;


  @override
  void initState() {
    calculatedFuelEfficiency = 0.0;
    calculateDiscount();
    super.initState();
  }

  @override
  void dispose() {
    mileageBeforeController.dispose();
    refuelledGasolineController.dispose();
    mileageAfterController.dispose();
    super.dispose();
  }

  void calculateDiscount() {
    mileageBeforeController.addListener(() {
      updateResult();
    });
    refuelledGasolineController.addListener(() {
      updateResult();
    });
    mileageAfterController.addListener(() {
      updateResult();
    });
  }

  void updateResult() {
    mileageBefore = mileageBeforeController.value.text;
    refuelledGasoline = refuelledGasolineController.value.text;
    mileageAfter = mileageAfterController.value.text;
    //Make null safety
    setState(() {

      double _mileageBefore = double.tryParse(mileageBefore)??0.0;
      double _refuelledGasoline = double.tryParse(refuelledGasoline)??0.0;
      double _mileageAfter = double.tryParse(mileageAfter)??0.0;

      double _totalMileage = _mileageAfter - _mileageBefore;
      calculatedFuelEfficiency = _totalMileage / _refuelledGasoline;

    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fuel Efficiency Calculator',
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () async {
                //await showInterstitialAd();
                resetPage(context, FuelEfficiencyCalcPage());
              },
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          BuildTextField(
                            title: 'Mileage Before Refueling',
                            hint: '0.0',
                            isEnabled: true,
                            textController: mileageBeforeController,
                            onPressedAction: null,
                            widget: Text('km', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                          BuildTextField(
                            title: 'The Amount of Refuelled Gasoline',
                            hint: '0.0',
                            isEnabled: true,
                            textController: refuelledGasolineController,
                            onPressedAction: null,
                            widget: Text('ℓ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                          BuildTextField(
                            title: 'Mileage After Driving',
                            hint: '0.0',
                            isEnabled: true,
                            textController: mileageAfterController,
                            onPressedAction: null,
                            widget: Text('km', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                        ],
                      ),
                    ),
                    //Result
                    Row(
                      children: [
                        BuildResultCard(title: 'Calculated Fuel Efficiency', value: '${calculatedFuelEfficiency.toStringAsFixed(4)} km/ℓ',),
                      ],
                    )
                  ],
                ),
              ),
            ),
            BuildBannerAd(),
          ],
        ),
      ),
    );
  }



}
