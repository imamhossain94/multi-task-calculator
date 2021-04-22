import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/components/build_result_card.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/components/build_value_slider.dart';
import 'package:multi_task_calculator/pages/unit_price_calc/components/build_header_item.dart';
import 'package:multi_task_calculator/pages/unit_price_calc/components/build_unit_price_row.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class UnitPriceCalcPage extends StatefulWidget {
  @override
  _UnitPriceCalcPageState createState() => _UnitPriceCalcPageState();
}

class _UnitPriceCalcPageState extends State<UnitPriceCalcPage> {
  TextEditingController billAmountController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  TextEditingController tipAmountController = TextEditingController();
  TextEditingController taxAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    billAmountController.dispose();
    numberOfPeopleController.dispose();
    tipAmountController.dispose();
    taxAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Unit Price Calculator',
            style: TextStyle(
                fontFamily: fontAudioWide, fontSize: responsiveWidth(18)),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                await showInterstitialAd();
                resetPage(context, unitPriceCalcPage);
              },
              icon: Icon(Icons.refresh_rounded),
              tooltip: 'Reset',
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: ThemesMode.isDarkMode ? Colors.black : textWhite,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: Offset.zero)
                    ]),
                child: Column(
                  children: [
                    buildUnitPriceHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                            BuildUnitPriceRow(),
                          ],
                        ),
                      ),
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

  Widget buildUnitPriceHeader() {
    return Row(
      children: [
        BuildHeaderItem(title: 'Total Price'),
        BuildHeaderItem(title: 'Quantity'),
        BuildHeaderItem(title: 'Unit Price'),
      ],
    );
  }

}


