import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_result_card.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/pages/loan_calc/components/loan_type_picker.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:url_launcher/url_launcher.dart';


class LoanCalcPage extends StatefulWidget {
  @override
  _LoanCalcPageState createState() => _LoanCalcPageState();
}

class _LoanCalcPageState extends State<LoanCalcPage> {

  TextEditingController mortgageAmountController = TextEditingController();
  TextEditingController monthlyPaymentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController periodController = TextEditingController();

  String mortgageAmount, monthlyPayment, interestRate, period, mortgageType;
  double totalCostResult, monthlyPaymentResult, youCouldBorrow;


  @override
  void initState() {
    totalCostResult = 0.0;
    monthlyPaymentResult = 0.0;
    youCouldBorrow = 0.0;
    mortgageType = 'Monthly Cost';
    calculateLoan();
    super.initState();
  }

  @override
  void dispose() {
    mortgageAmountController.dispose();
    monthlyPaymentController.dispose();
    interestRateController.dispose();
    periodController.dispose();
    super.dispose();
  }

  void calculateLoan() {
    mortgageAmountController.addListener(() {
      updateResult();
    });
    monthlyPaymentController.addListener(() {
      updateResult();
    });
    interestRateController.addListener(() {
      updateResult();
    });
    periodController.addListener(() {
      updateResult();
    });
  }

  void updateResult() {
    mortgageAmount = mortgageAmountController.value.text;
    monthlyPayment = monthlyPaymentController.value.text;
    interestRate = interestRateController.value.text;
    period = periodController.value.text;
    //Make null safety
    setState(() {

      double _mortgageAmount = double.tryParse(mortgageAmount)??0.0;
      double _monthlyPayment = double.tryParse(monthlyPayment) ?? 0.0;
      double _interestRate = double.tryParse(interestRate)??0.0;
      int months = int.tryParse(period)??0;

      _interestRate = _interestRate / 100 / 12;
      months = months * 12;

      double monthlyTop = _interestRate * pow((1 + _interestRate), months);
      double monthlyBottom = pow(1 + _interestRate, months) - 1;

      if(mortgageType == 'Monthly Cost'){

        double monthlyRate = _mortgageAmount * (monthlyTop / monthlyBottom);
        double totalPayment = monthlyRate * months;
        //result
        totalCostResult = totalPayment;
        monthlyPaymentResult = monthlyRate;

      }else if(mortgageType == 'Maximum Loan'){

        double borrowAmount = _monthlyPayment / (monthlyTop / monthlyBottom);
        double totalPayment = _monthlyPayment * months;
        //result
        totalCostResult = totalPayment;
        youCouldBorrow = borrowAmount;
        
      }



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
          title: Text('Loan Calculator',
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
                resetPage(context, LoanCalcPage());
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
                          LoanTypePicker(
                            title: 'Mortgage Type',
                            valueChanged: (String value) {
                              setState(() {
                                print(value);
                                mortgageType = value;
                                updateResult();
                              });
                            },
                          ),
                          BuildTextField(
                            title: mortgageType == 'Monthly Cost'?'Mortgage Amount':'Monthly Payment',
                            hint: '0.0',
                            isEnabled: true,
                            textController: mortgageType == 'Monthly Cost'?mortgageAmountController:monthlyPaymentController,
                            onPressedAction: null,
                            widget: Text('\$', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                          BuildTextField(
                            title: 'Interest Rate',
                            hint: '0.0',
                            isEnabled: true,
                            textController: interestRateController,
                            onPressedAction: null,
                            widget: Text('%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),

                          BuildTextField(
                            title: 'Period',
                            hint: '0',
                            isEnabled: true,
                            textController: periodController,
                            onPressedAction: null,
                            widget: Text('yrs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        BuildResultCard(title: 'Total Cost', value: totalCostResult.toStringAsFixed(2),),
                        mortgageType == 'Monthly Cost'?
                        BuildResultCard(title: 'Monthly Payments', value: monthlyPaymentResult.toStringAsFixed(2),):
                        BuildResultCard(title: 'You Could Borrow', value: youCouldBorrow.toStringAsFixed(2),),
                      ],
                    ),

                    buildSuggestion(),
                  ],
                ),
              ),
            ),
            //BuildBannerAd(),
          ],
        ),
      ),
    );
  }

  Widget buildSuggestion() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      alignment: Alignment.center,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'If you want advanced mortgage calculator '
                'please download our mortgage application from Play Store.',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: responsiveText(15),),
          ),
          SizedBox(height: 15,),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () async {
                if (await canLaunch(loanAppLink)) {
                  await launch(loanAppLink);
                } else {
                  throw 'Could not launch $loanAppLink';
                }
              },
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('Download Now', style: TextStyle(
                  color: ThemesMode.isDarkMode?textYellow:textBlack,
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
