import 'package:flutter/material.dart';
import 'package:multi_task_calculator/pages/general_calc_page/components/build_calc_pad.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:function_tree/function_tree.dart';

class GeneralCalcPage extends StatefulWidget {
  @override
  _GeneralCalcPageState createState() => _GeneralCalcPageState();
}

class _GeneralCalcPageState extends State<GeneralCalcPage> {

  String displayString='0', mathString='0', outputString='';

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
          title: Text('General Calculator',
            style: TextStyle(
              fontFamily: fontAudioWide,
              fontSize: responsiveWidth(18)
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.history,
                ),
                tooltip: 'History',
                onPressed: () async {
                  // bool result = await onDeletePressed(context);
                  // if (result) {
                  //   setState(() {
                  //     box.clear();
                  //     _history.clear();
                  //   });
                  // }
                })
          ],
        ),

        body: Column(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(4, 10, 4, 6),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ThemesMode.isDarkMode?Colors.black87:Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              displayString,
                              textAlign: TextAlign.end,
                              //overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: responsiveHeight(32),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ),
                      Divider(),
                      Text(
                        outputString,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: responsiveHeight(32),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            BuildCalcPad(
              onPressed: (value) {
                setState(() {

                  int len = displayString.length;

                  if(value == 'more'){
                    //Open advanced menu
                    showMoreMenu(context);
                  }else if(value == 'C'){
                    //Clear screen
                    clearScreen(context);
                  }else if((value == 'del') && (displayString != null)){
                    //Delete display character
                    if((len > 1)){
                      displayString = displayString.substring(0, len - 1);
                    }else{
                      displayString = '0';
                    }
                    mathString = displayString;
                    realtimeEvaluateExpression();
                  }else if(value == '='){
                    //Calculate the result
                    evaluateExpression(context);
                  }else if(len == 1 && displayString == '0' && !'+×÷^%'.contains(value)){
                    //Delete initial character
                    displayString = displayString.substring(0, displayString.length - 1);
                    displayString += value;
                    mathString = mathString.substring(0, mathString.length - 1);
                    mathString += convertValue(value);
                  }else{
                    displayString += value;
                    mathString += convertValue(value);
                    realtimeEvaluateExpression();
                  }


                });
              },
            ),
          ],
        ),
      ),
    );
  }

  //Open more menu
  void showMoreMenu(BuildContext context) {
    //

  }
  //Clear Screen
  void clearScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => GeneralCalcPage(),
      ),
    );
  }

  String convertValue(String symbol){
    if(symbol == '÷'){
      return '/';
    }else if(symbol == '×'){
      return '*';
    }else if(symbol == '–'){
      return '-';
    }else{
      return symbol;
    }
  }

  void evaluateExpression(BuildContext context){
    final mathExpression = mathString.replaceAll('%', '/100');
    try{
      outputString = mathExpression.interpret().toString();
    }catch(e){
      outputString = 'Invalid expression';
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect math exception', style: TextStyle(color: ThemesMode.isDarkMode?textAmber:textMaroon),),
            backgroundColor: ThemesMode.isDarkMode?backgroundDark:textWhite,
            behavior: SnackBarBehavior.floating,
          )
      );
    }
  }

  void realtimeEvaluateExpression(){
    final mathExpression = mathString.replaceAll('%', '/100');
    try{
      outputString = mathExpression.interpret().toString();
    }catch(e){
      outputString = '';
    }
  }

}
