import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_pop_up_munu_item.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildPopupMenuButton extends StatelessWidget {
  const BuildPopupMenuButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);

    return PopupMenuButton<int>(
      color: ThemesMode.isDarkMode?Colors.black87:Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),

      padding: EdgeInsets.zero,
      onSelected: (index) async{

        print(index);
        if(index == 0){
          themeChoiceDialogue(context);
        }else if(index == 1){

        }else if(index == 2){
          onRatingPressed(context);
        }else if(index == 3){
          Share.share('Hey check out this android app $appLink');
        }else if(index == 4){
          if (await canLaunch(storeLink)) {
            await launch(storeLink);
          } else {
            throw 'Could not launch $storeLink';
          }
        }else if(index == 5){
          if (await canLaunch(feedbackMail)) {
            await launch(feedbackMail);
          } else {
            throw 'Could not launch $feedbackMail';
          }
        }else if(index == 6){
          Navigator.pushNamed(context, aboutPage);
        }
      },
      offset: Offset(0, 10),
      //key: _key,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
              child: BuildPopUpMenuItem(
                icon: Icon(
                  Icons.color_lens,
                  color: textAmber,
                ),
                text: 'Themes',
              ),
              value: 0),
          PopupMenuItem<int>(
              child: BuildPopUpMenuItem(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: textMaroon,
                ),
                text: 'Remove Ads',
              ),
              value: 1),
          PopupMenuItem<int>(
              child: BuildPopUpMenuItem(
                icon: Icon(
                  Icons.star,
                  color: textBlue,
                ),
                text: 'Rate The App',
              ),
              value: 2),
          PopupMenuItem<int>(
              child: BuildPopUpMenuItem(
                icon: Icon(
                  Icons.share_rounded,
                  color: textMaroon,
                ),
                text: 'Share',
              ),
              value: 3),
          PopupMenuItem<int>(
              child: BuildPopUpMenuItem(
                icon: Icon(
                  Icons.shop_rounded,
                  color: textMaroon,
                ),
                text: 'Other Apps', ),
              value: 4),
          PopupMenuItem<int>(
              child: BuildPopUpMenuItem(
                icon: Icon(
                  Icons.mail,
                  color: textGreen,
                ),
                text: 'Feedback',
              ),
              value: 5),
          PopupMenuItem<int>(
              child: BuildPopUpMenuItem(
                icon: Icon(
                  Icons.android_sharp,
                  color: textMaroon,
                ),
                text: 'About',
              ),
              value: 6),
        ];
      },
    );
  }
}
