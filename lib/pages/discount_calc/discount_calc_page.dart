import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';


class DiscountCalcPage extends StatefulWidget {
  @override
  _DiscountCalcPageState createState() => _DiscountCalcPageState();
}

class _DiscountCalcPageState extends State<DiscountCalcPage> {


  TextEditingController originalAmountController = TextEditingController();
  TextEditingController addedTaxController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();

  String originalAmount, addedTax, discountPercentage;
  double amountSaved, finalPrice;


  @override
  void initState() {
    amountSaved = 0.0;
    finalPrice = 0.0;
    calculateDiscount();
    super.initState();
  }

  @override
  void dispose() {
    originalAmountController.dispose();
    addedTaxController.dispose();
    discountPercentageController.dispose();
    super.dispose();
  }

  void calculateDiscount() {
    originalAmountController.addListener(() {
      updateResult();
    });
    addedTaxController.addListener(() {
      updateResult();
    });
    discountPercentageController.addListener(() {
      updateResult();
    });

  }

  void updateResult() {
    originalAmount = originalAmountController.value.text;
    addedTax = addedTaxController.value.text;
    discountPercentage = discountPercentageController.value.text;
    //Make null safety
    setState(() {

      double _originalAmount = double.tryParse(originalAmount)??0.0;
      double _addedTax = double.tryParse(addedTax)??0.0;
      double _discountPercentage = double.tryParse(discountPercentage)??0.0;


      amountSaved = ((_originalAmount * _addedTax / 100) +_originalAmount) * ((_discountPercentage /100));
      finalPrice = ((_originalAmount * (_addedTax / 100)) + _originalAmount) - amountSaved;
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Discount Calculator',
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: ()=> resetPage(context, DiscountCalcPage()),
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
            )
          ],
        ),
        body: SingleChildScrollView(
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
                      title: 'Original Price',
                      hint: '0.0',
                      isEnabled: true,
                      textController: originalAmountController,
                      onPressedAction: null,
                      widget: Text('\$', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                    BuildTextField(
                      title: 'Added Tax',
                      hint: '0.0',
                      isEnabled: true,
                      textController: addedTaxController,
                      onPressedAction: null,
                      widget: Text('%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                    BuildTextField(
                      title: 'Discount Percentage',
                      hint: '0.0',
                      isEnabled: true,
                      textController: discountPercentageController,
                      onPressedAction: null,
                      widget: Text('%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                  ],
                ),
              ),

              //Result

              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          Text(
                            amountSaved.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: responsiveText(26), fontWeight: FontWeight.bold),
                          ),

                          Divider(),

                          Text(
                            'Amount Saved',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: responsiveText(14), fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          Text(
                            finalPrice.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: responsiveText(26), fontWeight: FontWeight.bold),
                          ),

                          Divider(),

                          Text(
                            'Final Price',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: responsiveText(14), fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }



}
