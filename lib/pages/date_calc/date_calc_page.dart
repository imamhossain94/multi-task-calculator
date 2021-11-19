import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:multi_task_calculator/components/build_result_card.dart';
import 'package:multi_task_calculator/components/build_text_field.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';


class DateCalcPage extends StatefulWidget {
  @override
  _DateCalcPageState createState() => _DateCalcPageState();
}

class _DateCalcPageState extends State<DateCalcPage> {

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  DateTime fromDate;
  DateTime toDate;

  String resultYears, resultMonths, resultDays;


  @override
  void initState() {
    resultYears = '0';
    resultMonths = '0';
    resultDays = '0';
    fromDate = DateTime.now();
    toDate = DateTime.now();
    fromDateController.text = fromDate.toString().substring(0,10);
    toDateController.text = toDate.toString().substring(0,10);
    super.initState();
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Date Calculator',
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
                resetPage(context, DateCalcPage());
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
                            title: 'From Date',
                            hint: 'dd/mm/yyyy'.toUpperCase(),
                            isEnabled: false,
                            textController: fromDateController,
                            onPressedAction: () async{
                              pickDateTime(context: context,
                                  title: 'From Date',
                                  valueChanged: (v){
                                    //print(v);
                                    fromDate = v;
                                    fromDateController.text = v.toString().substring(0,10);
                                    int days = toDate.difference(fromDate).inDays;
                                    print(days);
                                    setState(() {
                                      resultYears = (days~/365).floor().toString();
                                      resultMonths = ((days%365)~/30.417).toString();
                                      resultDays = (((days%365)%30.417).toInt()).toString();
                                      // resultYears = (days~/365).floor().toString();
                                      // resultMonths = ((days%365)~/12).toString();
                                      // resultDays = (((days%365)%12)).toString();
                                    });
                                  }
                              );

                            },
                            widget: Icon(Icons.date_range_rounded, size: responsiveText(18),),),

                          BuildTextField(
                            title: 'To Date',
                            hint: 'dd/mm/yyyy'.toUpperCase(),
                            isEnabled: false,
                            textController: toDateController,
                            onPressedAction: () async{
                              pickDateTime(context: context,
                                title: 'To Date',
                                valueChanged: (v){
                                  toDate = v;
                                  toDateController.text = v.toString().substring(0,10);
                                  int days = toDate.difference(fromDate).inDays;
                                  print(days);
                                  setState(() {
                                    resultYears = (days~/365).floor().toString();
                                    resultMonths = ((days%365)~/12).toString();
                                    resultDays = (((days%365)%12)).toString();
                                  });
                                }
                              );

                              // print(toDate);
                              // toDateController.text = toDate.toString();
                              // int days = toDate.difference(fromDate).inHours;
                              // print(days);
                              // setState(() {
                              //   resultYears = (days~/365).toString();
                              //   resultMonths = (days~/12).toString();
                              //   resultDays = (days).toString();
                              // });
                            },
                            widget: Icon(Icons.date_range_rounded, size: responsiveText(18),),),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        BuildResultCard(title: 'Years', value: resultYears,),
                        BuildResultCard(title: 'Month', value: resultMonths,),
                        BuildResultCard(title: 'Days', value: resultDays,),
                      ],
                    ),

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

  Future<bool> pickDateTime({BuildContext context, String title, ValueChanged<DateTime> valueChanged}) async {
    DateTime _selectedDate;
    return showModalBottomSheet(
      barrierColor: ThemesMode.isDarkMode?Colors.black54:Colors.white54,
      context: context,
      elevation: 0.0,
      enableDrag: false,
      builder: (context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(responsiveWidth(8)),
          padding: EdgeInsets.fromLTRB(responsiveWidth(15), responsiveWidth(10), responsiveWidth(15), responsiveWidth(15)),
          decoration: BoxDecoration(
              color: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
              //border: Border.all(width: 0.5, color: Colors.black12),
              borderRadius: BorderRadius.circular(responsiveWidth(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    blurRadius: responsiveWidth(3),
                    spreadRadius: responsiveWidth(3),
                    offset: Offset.zero)
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(title, style: TextStyle(fontSize: responsiveText(18), fontWeight: FontWeight.bold)),
                  Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context,);
                      valueChanged(_selectedDate);
                    },
                    child: Icon(Icons.done)
                  )
                ],
              ),
              Divider(),
              DatePickerWidget(
                looping: true,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                initialDate: DateTime.now(),
                locale: DateTimePickerLocale.en_us,
                dateFormat:"dd-MMMM-yyyy",
                onChange: (DateTime newDate, _) {
                  _selectedDate = newDate;
                  valueChanged(newDate);
                  //print(_selectedDate);
                },
                pickerTheme: DateTimePickerTheme(
                  backgroundColor: ThemesMode.isDarkMode?backgroundDark:backgroundLight,
                  itemTextStyle: TextStyle(
                      fontSize: responsiveText(14),
                      color: ThemesMode.isDarkMode?textWhite:textBlack
                  ),
                  itemHeight: responsiveHeight(80),
                  dividerColor: Colors.transparent,
                ),
              ),
            ],
          )
        );
      },
    );
  }
}
