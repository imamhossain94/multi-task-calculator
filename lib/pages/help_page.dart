import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class HelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          title: Text('Help',
            style: TextStyle(
                fontSize: responsiveText(22),
                fontFamily: fontAudioWide,),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          children: buildHelpList(),
        ),
      ),
    );
  }

  Widget questionAnswer({String question, String answer}){
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      color: ThemesMode.isDarkMode?Colors.black26:Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: responsiveText(18), fontWeight: FontWeight.bold),
          ),
          Text(
            answer,
            style: TextStyle(fontSize: responsiveText(14),),
          ),
        ],
      ),
    );
  }

  List<Widget> buildHelpList() {
    Map<String, String> helps = appHelp;
    return helps.entries.map((qNa) {
      return Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1),
        child: questionAnswer(
          question: qNa.key,
          answer: qNa.value,
        ),
      );
    }).toList();
  }

}
