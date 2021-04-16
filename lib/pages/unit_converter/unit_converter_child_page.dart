import 'package:flutter/material.dart';
import 'package:multi_task_calculator/pages/unit_converter/components/build_unit_text_field.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class UnitConverterChildPage extends StatefulWidget {
  @override
  _UnitConverterChildPageState createState() => _UnitConverterChildPageState();
}

class _UnitConverterChildPageState extends State<UnitConverterChildPage> {

  TextEditingController fromUnitController = TextEditingController();
  TextEditingController toUnitController = TextEditingController();

  String fromUnit = currencyCodeList.entries.elementAt(0).key;
  String toUnit = currencyCodeList.entries.elementAt(1).key;

  //
  // ExchangeRateApi exchangeRateApi;
  // List<CurrencyRates> currencyRates = [];
  //
  // bool isLoading = true;
  //
  // @override
  // void initState() {
  //   fromCurrencyController.text = '1.0';
  //   toCurrencyController.text = '1.0';
  //   getExchangeRate();
  //   fromCurrencyController.addListener((){
  //     setState(() {
  //       String  fromCurrencyValue = fromCurrencyController.value.text;
  //       currencyRates = exchangeRateApi.conversionRates.getCurrencyRateLIst(
  //           double.tryParse(fromCurrencyValue)??1.0
  //       );
  //       currencyRates.forEach((obj) {
  //         if(obj.code.toUpperCase() == toCurrency){
  //           toCurrencyController.text = (double.tryParse(obj.rates)??0.0).toStringAsFixed(2);
  //         }
  //       });
  //     });
  //   });
  //
  //   super.initState();
  // }

  @override
  void dispose() {
    fromUnitController.dispose();
    toUnitController.dispose();
    super.dispose();
  }
  //
  // void getExchangeRate() async{
  //   setState(() {
  //     isLoading = true;
  //   });
  //   ExchangeRateApiResponse exchangeRateApiResponse = await CurrencyApiServices().getExchangeRate(fromCurrency);
  //   setState(() {
  //     exchangeRateApi = exchangeRateApiResponse.exchangeRateApi;
  //     //print(exchangeRateApi.result);
  //     String  fromCurrencyValue = fromCurrencyController.value.text;
  //     currencyRates = exchangeRateApiResponse.exchangeRateApi.conversionRates.getCurrencyRateLIst(double.tryParse(fromCurrencyValue)??1.0);
  //
  //     currencyRates.forEach((obj) {
  //       if(obj.code.toUpperCase() == toCurrency){
  //         toCurrencyController.text = double.parse(obj.rates).toStringAsFixed(2);
  //       }
  //     });
  //     isLoading = false;
  //   });
  // }


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
            IconButton(
              onPressed: ()=> resetPage(context, UnitConverterChildPage()),
              icon: Icon(Icons.refresh),
              tooltip: 'Reset',
            )
          ],
        ),
        body: Column(
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
                  BuildUnitTextField(
                    isEnabled: true,
                    hint: fromUnitController.text,
                    title: 'From Unit',
                    unitName: fromUnit,
                    textController: fromUnitController,
                    onPressedAction: () {
                      showUnitPicker(context, (v){
                        FocusScope.of(context).unfocus();
                          setState(() {
                            fromUnit = v;
                            //getExchangeRate();
                          });
                      });
                    },
                  ),
                  BuildUnitTextField(
                    isEnabled: false,
                    hint: toUnitController.text,
                    title: 'To Unit',
                    unitName: toUnit,
                    textController: toUnitController,
                    onPressedAction: () {
                      showUnitPicker(context, (v){
                        FocusScope.of(context).unfocus();
                        setState(() {
                          toUnit = v;
                          // currencyRates.forEach((obj) {
                          //   if(obj.code.toUpperCase() == toCurrency){
                          //     toCurrencyController.text = (double.tryParse(obj.rates)??0.0).toStringAsFixed(2);
                          //   }
                          // });
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
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // Expanded(
                    //   child: ListView.builder(
                    //       physics: BouncingScrollPhysics(),
                    //       itemCount: currencyRates.length,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return Container(
                    //           margin: EdgeInsets.all(8),
                    //           padding: EdgeInsets.all(8),
                    //           decoration: BoxDecoration(
                    //             color: Colors.grey.withOpacity(0.3),
                    //             borderRadius: BorderRadius.circular(5),
                    //           ),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Text(currencyRates[index].code.toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    //                   Spacer(),
                    //                   //${currencyRates[index].symbol}
                    //                   Text((double.tryParse(currencyRates[index].rates)??0.0).toStringAsFixed(2), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    //                 ],
                    //               ),
                    //               Text(currencyRates[index].definition,),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     ),
                    // )
                    //

                  ],
                )

              ),
            )
          ],
        ),
      ),
    );
  }






  Future<bool>  showUnitPicker(BuildContext context, ValueChanged<String> valueChanged) {
    return showModalBottomSheet(
      context: context,
      elevation: 0.0,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.63,
          minChildSize: 0.30,
          maxChildSize: 0.63,
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
                        color: Colors.grey.withOpacity(0.9),
                        blurRadius: responsiveWidth(3),
                        spreadRadius: responsiveWidth(3),
                        offset: Offset.zero)
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Text('Select Currency', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Spacer(),
                        IconButton(icon: Icon(Icons.close), onPressed: (){
                          Navigator.pop(context, false);
                          return 'USD';
                        })
                      ],
                    )
                  ),
                  Expanded(
                    child:
                    ListView.builder(
                      controller: controller,
                      physics: BouncingScrollPhysics(),
                      itemCount: currencyCodeList.entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          child: InkWell(
                            onTap: (){
                              valueChanged(currencyCodeList.entries.elementAt(index).key);
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
                                  Text(currencyCodeList.entries.elementAt(index).value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(currencyCodeList.entries.elementAt(index).key, style: TextStyle()),
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
