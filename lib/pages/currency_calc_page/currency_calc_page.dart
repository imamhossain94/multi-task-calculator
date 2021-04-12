import 'package:flutter/material.dart';
import 'package:multi_task_calculator/pages/currency_calc_page/components/build_drop_down_field.dart';
import 'package:multi_task_calculator/pages/currency_calc_page/components/build_search_field.dart';
import 'package:multi_task_calculator/pages/currency_calc_page/components/build_text_field.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class CurrencyCalcPage extends StatefulWidget {
  @override
  _CurrencyCalcPageState createState() => _CurrencyCalcPageState();
}

class _CurrencyCalcPageState extends State<CurrencyCalcPage> {

  TextEditingController searchEditingController = TextEditingController();


  @override
  void initState() {
    //inputString = '0';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Currency Converter',
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [

          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(child: BuildDropDownField(title: 'From', value: 'USD', onPressed: () {  },)),
                      Expanded(child: BuildTextField(symbol: '\$', value: '1', onPressed: () {  },)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: BuildDropDownField(title: 'To', value: 'BDT', onPressed: () {  },)),
                      Expanded(child: BuildTextField(symbol: 't', value: '84.61', onPressed: null,)),
                    ],
                  ),
                ],
              ),
            ),

            BuildSearchField(
              hint: 'Search keyword',
              textController: searchEditingController,
              inputType: TextInputType.number,
            ),

            //List
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),

                  ],
                ),

              ),
            )


          ],
        ),
      ),
    );
  }



}
