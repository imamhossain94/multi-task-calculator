import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/components/build_result_card.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';


class FuelCostCalcPage extends StatefulWidget {
  @override
  _FuelCostCalcPageState createState() => _FuelCostCalcPageState();
}

class _FuelCostCalcPageState extends State<FuelCostCalcPage> {


  TextEditingController distanceController = TextEditingController();
  TextEditingController fuelEfficiencyController = TextEditingController();
  TextEditingController fuelPriceController = TextEditingController();

  String distance, fuelEfficiency, fuelPrice;

  double estimatedCost, estimatedAmountOfFuel;


  @override
  void initState() {
    estimatedCost = 0.0;
    estimatedAmountOfFuel = 0.0;
    calculateDiscount();
    super.initState();
  }

  @override
  void dispose() {
    distanceController.dispose();
    fuelEfficiencyController.dispose();
    fuelPriceController.dispose();
    super.dispose();
  }

  void calculateDiscount() {
    distanceController.addListener(() {
      updateResult();
    });
    fuelEfficiencyController.addListener(() {
      updateResult();
    });
    fuelPriceController.addListener(() {
      updateResult();
    });

  }

  void updateResult() {
    distance = distanceController.value.text;
    fuelEfficiency = fuelEfficiencyController.value.text;
    fuelPrice = fuelPriceController.value.text;
    //Make null safety
    setState(() {

      double _distance = double.tryParse(distance)??0.0;
      double _fuelEfficiency = double.tryParse(fuelEfficiency)??0.0;
      double _fuelPrice = double.tryParse(fuelPrice)??0.0;

      estimatedAmountOfFuel = _distance/_fuelEfficiency;
      estimatedCost = estimatedAmountOfFuel * _fuelPrice;

    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fuel Cost Calculator',
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                await showInterstitialAd();
                resetPage(context, fuelCalcPage);
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
                            title: 'Distance to Travel Price',
                            hint: '0.0',
                            isEnabled: true,
                            textController: distanceController,
                            onPressedAction: null,
                            widget: Text('km', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                          BuildTextField(
                            title: 'Fuel Efficiency',
                            hint: '0.0',
                            isEnabled: true,
                            textController: fuelEfficiencyController,
                            onPressedAction: null,
                            widget: Text('km/ℓ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                          BuildTextField(
                            title: 'Fuel Price',
                            hint: '0.0',
                            isEnabled: true,
                            textController: fuelPriceController,
                            onPressedAction: null,
                            widget: Text('\$/ℓ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                        ],
                      ),
                    ),
                    //Result
                    Row(
                      children: [
                        BuildResultCard(title: 'Estimated Cost\n---', value: '\$${estimatedCost.toStringAsFixed(2)}',),
                        BuildResultCard(title: 'Estimated Amount of Fuel', value: '${estimatedAmountOfFuel.toStringAsFixed(3)}ℓ',),
                      ],
                    ),

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
