import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_result_card.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/pages/health_calc/components/build_gender_picker.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';


class HealthCalcPage extends StatefulWidget {
  @override
  _HealthCalcPageState createState() => _HealthCalcPageState();
}

class _HealthCalcPageState extends State<HealthCalcPage> {

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String height, weight, age, gender, status;
  double bmi, bmr;


  @override
  void initState() {
    bmi = 0.0;
    bmr = 0.0;
    gender = 'Male';
    calculateDiscount();
    super.initState();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void calculateDiscount() {

    heightController.addListener(() {
      updateResult();
    });
    weightController.addListener(() {
      updateResult();
    });
    ageController.addListener(() {
      updateResult();
    });

  }

  void updateResult() {

    height = heightController.value.text;
    weight = weightController.value.text;
    age = ageController.value.text;
    //Make null safety
    if(height.isNotEmpty || weight.isNotEmpty){
      setState(() {
        double _height = double.tryParse(height)??0.0;
        double _weight = double.tryParse(weight)??0.0;

        bmi = _weight /((_height/100) * _height/100);


        if(age.isNotEmpty){
          double _age = double.tryParse(age)??0;
          if(gender == 'Male'){
            bmr = 10 * _weight +  6.25 * _height - 5 * _age + 5;
            //bmr = 88.362 + (13.397 * _weight) + (4.799 * _height) - (5.677 * _age);
          }else if(gender == 'Female'){
            bmr = 10 * _weight +  6.25 * _height - 5 * _age -161;
            //bmr = 447.593 + (9.247 * _weight) + (3.098 * _height) - (4.330 * _age);
          }

          if(bmi < 18.5){
            status = 'Underweight';
          }else if(bmi >= 18.5 && bmi <=24.9){
            status = 'Healthy weight';
          }else if(bmi >= 25.0 && bmi <=29.9){
            status = 'Overweight';
          }else if(bmi >= 30.0 && bmi <=39.9){
            status = 'Obese';
          }
        }else{
          status = null;
        }



      });
    }
  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Health Calculator',
            style: TextStyle(
                fontFamily: fontAudioWide,
                fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                //await showInterstitialAd();
                resetPage(context, healthCalcPage);
              },
              icon: Icon(Icons.refresh),
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

                          BuildGenderPicker(
                            valueChanged: (String value) {
                              print(value);
                              setState(() {
                                gender = value;
                                updateResult();
                              });

                            },
                            title: 'Gender',
                          ),

                          BuildTextField(
                            title: 'Height',
                            hint: '0.0',
                            isEnabled: true,
                            textController: heightController,
                            onPressedAction: null,
                            widget: Text('cm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                          BuildTextField(
                            title: 'Weight',
                            hint: '0.0',
                            isEnabled: true,
                            textController: weightController,
                            onPressedAction: null,
                            widget: Text('kg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                          BuildTextField(
                            title: 'Age',
                            hint: '0.0',
                            isEnabled: true,
                            textController: ageController,
                            onPressedAction: null,
                            widget: Text('yrs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: responsiveText(16)),),),
                        ],
                      ),
                    ),
                    //Result
                    Row(
                      children: [
                        BuildResultCard(title: 'BMI', value: '${bmi.toStringAsFixed(2)}',),
                        BuildResultCard(title: 'BMR', value: '${bmr.toStringAsFixed(2)}',),
                      ],
                    ),

                   status != null?
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
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
                      child: Text(
                        'Status: $status',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: responsiveText(26), fontWeight: FontWeight.bold),
                      ),
                    ):SizedBox(),
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

}




