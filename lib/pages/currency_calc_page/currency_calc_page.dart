import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/pages/currency_calc_page/model/exchange_rate_api_response.dart';
import 'package:multi_task_calculator/services/currency_api.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'components/build_currency_text_field.dart';
import 'model/exchange_rate_api.dart';

class CurrencyCalcPage extends StatefulWidget {
  @override
  _CurrencyCalcPageState createState() => _CurrencyCalcPageState();
}

class _CurrencyCalcPageState extends State<CurrencyCalcPage> {

  TextEditingController searchCurrencyController = TextEditingController();
  TextEditingController fromCurrencyController = TextEditingController();
  TextEditingController toCurrencyController = TextEditingController();

  String fromCurrency = currencyCodeList.entries.elementAt(142).key;
  String toCurrency = currencyCodeList.entries.elementAt(12).key;

  ExchangeRateApi exchangeRateApi;
  List<CurrencyRates> currencyRates = [];

  bool isLoading = true;

  @override
  void initState() {
    fromCurrencyController.text = '1.0';
    toCurrencyController.text = '1.0';
    getExchangeRate();
    fromCurrencyController.addListener((){
      setState(() {
        String  fromCurrencyValue = fromCurrencyController.value.text;
        currencyRates = exchangeRateApi.conversionRates.getCurrencyRateLIst(
            double.tryParse(fromCurrencyValue)??1.0
        );
        currencyRates.forEach((obj) {
          if(obj.code.toUpperCase() == toCurrency){
            toCurrencyController.text = (double.tryParse(obj.rates)??0.0).toStringAsFixed(2);
          }
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    fromCurrencyController.dispose();
    toCurrencyController.dispose();
    super.dispose();
  }

  void getExchangeRate() async{
    setState(() {
      isLoading = true;
    });
    ExchangeRateApiResponse exchangeRateApiResponse = await CurrencyApiServices().getExchangeRate(fromCurrency);
    setState(() {
      exchangeRateApi = exchangeRateApiResponse.exchangeRateApi;
      //print(exchangeRateApi.result);
      String  fromCurrencyValue = fromCurrencyController.value.text;
      currencyRates = exchangeRateApiResponse.exchangeRateApi.conversionRates.getCurrencyRateLIst(double.tryParse(fromCurrencyValue)??1.0);

      currencyRates.forEach((obj) {
        if(obj.code.toUpperCase() == toCurrency){
          toCurrencyController.text = double.parse(obj.rates).toStringAsFixed(2);
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
          title: Text('Currency Converter',
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: ()=> getExchangeRate(),
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
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
                  BuildCurrencyTextField(
                    isEnabled: true,
                    hint: fromCurrencyController.text,
                    title: 'From Currency',
                    currencyCode: fromCurrency,
                    textController: fromCurrencyController,
                    onPressedAction: () {
                      showCountryPicker(context, (v){
                        FocusScope.of(context).unfocus();
                          setState(() {
                            fromCurrency = v;
                            getExchangeRate();
                          });
                      });
                    },
                  ),
                  BuildCurrencyTextField(
                    isEnabled: false,
                    hint: toCurrencyController.text,
                    title: 'To Currency',
                    currencyCode: toCurrency,
                    textController: toCurrencyController,
                    onPressedAction: () {
                      showCountryPicker(context, (v){
                        FocusScope.of(context).unfocus();
                        setState(() {
                          toCurrency = v;
                          currencyRates.forEach((obj) {
                            if(obj.code.toUpperCase() == toCurrency){
                              toCurrencyController.text = (double.tryParse(obj.rates)??0.0).toStringAsFixed(2);
                            }
                          });
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
                    // Container(
                    //   margin: EdgeInsets.only(top: 8, bottom: 5),
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey.withOpacity(0.3),
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: TextField(
                    //     controller: searchCurrencyController,
                    //     decoration: InputDecoration(
                    //       prefix: SizedBox(
                    //         width: 10,
                    //       ),
                    //       border: InputBorder.none,
                    //       hintText: 'Search Currency',
                    //     ),
                    //     keyboardType: TextInputType.number,
                    //     textInputAction: TextInputAction.done,
                    //     autocorrect: false,
                    //     obscureText: false,
                    //   ),
                    // ),
                    // Divider(),
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
                          itemCount: currencyRates.length,
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
                                      Text(currencyRates[index].code.toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      //${currencyRates[index].symbol}
                                      Text((double.tryParse(currencyRates[index].rates)??0.0).toStringAsFixed(2), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Text(currencyRates[index].definition,),
                                ],
                              ),
                            );
                          },
                        ),),
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

  Future<bool>  showCountryPicker(BuildContext context, ValueChanged<String> valueChanged) {
    return showModalBottomSheet(
      context: context,
      elevation: 0.0,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
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
