import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/services/shared_pref_services.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class PremiumPage extends StatefulWidget {
  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {

  GoogleAdService _googleAdService = GoogleAdService();

  String rewardSeconds;
  bool isLoading;
  Timer _timer;

  @override
  void initState() {
    isLoading = false;
    createTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void createTimer() async{
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t)=>
      setState((){
        if(getAppPurchasedStatus() == true){
          DateTime x = DateTime.now(), y = DateTime.tryParse(getAdFreeTime());
          int seconds = x.difference(y).inSeconds;
          rewardSeconds = seconds.toString();
          if(seconds == 21600){
            t.cancel();
            rewardSeconds = null;
            setAppPurchasedStatus(false);
          }
        }else{
          rewardSeconds = null;
          t.cancel();
        }
      })
    );

  }


  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Premium version',
              style: TextStyle(
                  fontSize: responsiveText(22),
                  fontFamily: 'Audiowide',),
            ),
          ),
          body: Container(
            //padding: EdgeInsets.all(responsiveWidth(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                rewardSeconds != null?buildClockCard(title: 'You are enjoying 360 minutes ad free version.', time: 'Remaining\n'
                    '${(21600-int.parse(rewardSeconds))~/60}:${(21600-int.parse(rewardSeconds))%60}'
                ):getAppPurchasedStatus() == true?Expanded(child: Center(child: SizedBox(height:40, width: 40,child: CircularProgressIndicator()))):
                    buildCard(title: Text(
                    'Watch a full video ad to remove all the bottom banner and Interstitial ads for 360 minutes for free.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsiveText(15),
                    ),
                  ),
                  actionWidget: isLoading?SizedBox(height:40, width: 40,child: CircularProgressIndicator()):Icon(FontAwesomeIcons.play, size: responsiveWidth(34),),
                  buttonText: 'Watch Now',
                  voidCallback: () async{
                    setState(() {
                      isLoading = true;
                    });
                    _googleAdService.initAd();
                    await Future.delayed(Duration(seconds: 5), () async{
                       await _googleAdService.showRewardedAd();
                    });
                    setState(() {
                      isLoading = false;
                      resetPage(context, premiumPage);
                    });
                  }
                ),

                buildCard(
                    title: Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize:  responsiveText(13),),
                        children: [
                          TextSpan(
                            text: 'If you purchase the premium version of the app.\n\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:  responsiveText(15),
                            ),
                          ),
                          TextSpan(text: '‣ All the ads will be permanently removed.\n',),
                          TextSpan(text: '‣ The purchase will be belong to your account.'),
                        ],
                      ),
                    ),
                    actionWidget: Text('\$4.99', style: TextStyle(
                        fontSize: responsiveText(40), fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                    ),
                    buttonText: 'Purchase',
                    voidCallback: (){

                    }
                )
              ],
            ),
          )),
    );
  }

  Widget buildCard({Widget title, Widget actionWidget, String buttonText, VoidCallback voidCallback}) {
    return Expanded(
      child: Container(
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
            title,
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: voidCallback,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: actionWidget,
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: voidCallback,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(buttonText, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemesMode.isDarkMode?textYellow:textBlack,
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildClockCard({String title, String time}) {
    return Expanded(
      child: Container(
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
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: responsiveText(15),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: null,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('$time s', style: TextStyle(
                        fontSize: responsiveText(40), fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

}
