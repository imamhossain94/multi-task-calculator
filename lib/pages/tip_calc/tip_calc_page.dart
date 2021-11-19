import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_banner_ad.dart';
import 'package:multi_task_calculator/components/build_result_card.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';


class TipCalcPage extends StatefulWidget {
  @override
  _TipCalcPageState createState() => _TipCalcPageState();
}

class _TipCalcPageState extends State<TipCalcPage> {

  TextEditingController billAmountController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  TextEditingController tipAmountController = TextEditingController();
  TextEditingController taxAmountController = TextEditingController();

  String billAmount, numberOfPeople, tipAmount, taxAmount;
  double finalAmount, amountPerPerson, tipPercentage, taxPercentage;
  bool tipAmountDollar = true, taxAmountDollar = true;


  @override
  void initState() {
    finalAmount = 0.0;
    amountPerPerson = 0.0;
    calculateTip();
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

  void calculateTip() {
    billAmountController.addListener(() {
      updateResult();
    });
    numberOfPeopleController.addListener(() {
      updateResult();
    });
    tipAmountController.addListener(() {
      updateResult();
    });
    taxAmountController.addListener(() {
      updateResult();
    });
  }

  void updateResult() {
    billAmount = billAmountController.value.text;
    numberOfPeople = numberOfPeopleController.value.text;
    tipAmount = tipAmountController.value.text;
    taxAmount = taxAmountController.value.text;
    //Make null safety
    setState(() {

      double _billAmount = double.tryParse(billAmount)??0.0;
      int _numberOfPeople = int.tryParse(numberOfPeople) ?? 0;
      double _tipAmount = double.tryParse(tipAmount)??0.0;
      double _taxAmount = double.tryParse(taxAmount)??0.0;

      if(_tipAmount == 0.0 && _taxAmount == 0.0){
          finalAmount = _billAmount;
          amountPerPerson = _billAmount / _numberOfPeople;
      }else if( _taxAmount == 0.0){

        if(tipAmountDollar){
          finalAmount = _billAmount + _tipAmount;
          amountPerPerson = finalAmount / _numberOfPeople;
        }else{
          finalAmount = _billAmount + (_billAmount * _tipAmount/100);
          amountPerPerson = finalAmount / _numberOfPeople;
        }

      }
      //else if(_billAmount != 0.0 && _taxAmount != 0.0 && _taxAmount != 0.0){
      //   if(taxAmountDollar){
      //
      //
      //     double _tempBillAmount = _billAmount - _taxAmount;
      //     double _tipPercent = (_taxAmount * 100) / _tempBillAmount;
      //     double _tipAmnt = _tempBillAmount * (_tipPercent/100);
      //     //_tipAmount = _tempBillAmount * (((_tipAmount * 100) / _tempBillAmount)/100);
      //
      //     finalAmount = _billAmount + _tipAmnt;
      //     amountPerPerson = finalAmount / _numberOfPeople;
      //     print(_tempBillAmount);
      //     print(_tipPercent);
      //     print(_tipAmnt);
      //
      //
      //   }
      //   // else{
      //   //   print('heat: ${_billAmount * _tipAmount/100}');
      //   //   finalAmount = _billAmount + (_billAmount * _tipAmount/100);
      //   //   amountPerPerson = finalAmount / _numberOfPeople;
      //   // }
      //
      // }

    });
  }

  void tipAmountToTipPercent(){

  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tip Calculator',
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
                await showInterstitialAd();
                resetPage(context, TipCalcPage());
              },
              icon: Icon(Icons.refresh_rounded),
              tooltip: 'Reset',
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
                            title: 'Bill Amount',
                            hint: '0.0',
                            isEnabled: true,
                            textController: billAmountController,
                            onPressedAction: null,
                            widget: Text('\$', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),

                          BuildTextField(
                            title: 'Number of People',
                            hint: '0.0',
                            isEnabled: true,
                            textController: numberOfPeopleController,
                            onPressedAction: null,
                            widget: Icon(Icons.people_rounded, size: responsiveText(18),),),

                          BuildTextField(
                            title: 'Tip Amount',
                            hint: '0.0',
                            isEnabled: true,
                            textController: tipAmountController,
                            onPressedAction: (){
                              billAmount = billAmountController.value.text;
                              tipAmount = tipAmountController.value.text;
                              double _billAmount = double.tryParse(billAmount)??0.0;
                              double _tipAmount = double.tryParse(tipAmount)??0.0;
                              setState(() {
                                if(tipAmountDollar){
                                  tipAmountDollar = false;
                                  tipAmountController.text = ((_tipAmount*100)/_billAmount).toString();
                                }else{
                                  tipAmountDollar = true;
                                  tipAmountController.text = ((_billAmount * _tipAmount/100)).toString();
                                }
                              });
                            },
                            widget: Text(tipAmountDollar?'\$':'%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),

                          // BuildTextField(
                          //   title: 'Tax Amount',
                          //   hint: '0.0',
                          //   isEnabled: true,
                          //   textController: taxAmountController,
                          //   onPressedAction: (){
                          //     billAmount = billAmountController.value.text;
                          //     numberOfPeople = numberOfPeopleController.value.text;
                          //     tipAmount = tipAmountController.value.text;
                          //     taxAmount = taxAmountController.value.text;
                          //
                          //     double _billAmount = double.tryParse(billAmount)??0.0;
                          //     int _numberOfPeople = int.tryParse(numberOfPeople) ?? 0;
                          //     double _tipAmount = double.tryParse(tipAmount)??0.0;
                          //     double _taxAmount = double.tryParse(taxAmount)??0.0;
                          //
                          //     // setState(() {
                          //     //   if(taxAmountDollar){
                          //     //     taxAmountDollar = false;
                          //     //     _tempBillAmount = _billAmount-_taxAmount;
                          //     //     //%
                          //     //     _taxAmount = ((_taxAmount*100)/_tempBillAmount);
                          //     //     taxAmountController.text = (_taxAmount).toString();
                          //     //     tipAmountController.text = (_tempBillAmount * _taxAmount/100).toString();
                          //     //   }else{
                          //     //     taxAmountDollar = true;
                          //     //     // _taxAmount = (_tempBillAmount * (_taxAmount/100));
                          //     //     // taxAmountController.text = (_taxAmount).toString();
                          //     //
                          //     //   }
                          //     // });
                          //   },
                          //   widget: Text(taxAmountDollar?'\$':'%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                        ],
                      ),
                    ),
                    //Result
                    Row(
                      children: [
                        BuildResultCard(title: 'Final Amount', value: finalAmount.toStringAsFixed(2),),
                        BuildResultCard(title: 'Amount per Person', value: amountPerPerson.toStringAsFixed(2),),
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
