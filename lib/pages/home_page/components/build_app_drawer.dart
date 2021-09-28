import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_task_calculator/components/build_app_logo.dart';
import 'package:multi_task_calculator/components/build_drawer_body_item.dart';
import 'package:multi_task_calculator/services/shared_pref_services.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:multi_task_calculator/utils/extensions.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildAppDrawer extends StatefulWidget {
  const BuildAppDrawer({
    Key key,
  }) : super(key: key);

  @override
  _BuildAppDrawerState createState() => _BuildAppDrawerState();
}

class _BuildAppDrawerState extends State<BuildAppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemesMode().init(context);
    ScreenConfig().init(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(responsiveWidth(8)),
      decoration: BoxDecoration(
        color: Colors.transparent,
          //color: ThemesMode.isDarkMode?Colors.black87:Colors.white,
          //border: Border.all(width: 0.5, color: Colors.black12),
          borderRadius: BorderRadius.circular(responsiveWidth(8)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                blurRadius: responsiveWidth(1),
                spreadRadius: responsiveWidth(1),
                offset: Offset.zero)
          ]),
      child: Drawer(
        elevation: 0.0,
        child: Container(
          color: ThemesMode.isDarkMode?Colors.black87:backgroundLight.withOpacity(0.5),
          child: ListView(
            padding: EdgeInsets.only(left: 5, right: 5),
            children: [
              DrawerHeader(
                child: BuildAppLogo()
              ),

              BuildDrawerBodyItem(
                  icon: Icon(
                    Icons.color_lens,
                    color: textAmber,
                  ),
                  text: 'Themes',
                  onTap: () {
                    themeChoiceDialogue(context);
                  }),

              BuildDrawerBodyItem(
                  icon: Icon(
                    Icons.live_help_rounded,
                    color: textMaroon,
                  ),
                  text: 'Help',
                  onTap: () {
                    //Navigator.pop(context);
                    Navigator.pushNamed(context, helpPage);
                  }),
              Divider(),
              // BuildDrawerBodyItem(
              //     icon: Icon(
              //       Icons.shopping_cart_rounded,
              //       color: textAmber,
              //     ),
              //     text: 'Premium',
              //     onTap: () => Navigator.pushNamed(context, premiumPage)),
              BuildDrawerBodyItem(
                  icon: Icon(
                    Icons.star_rate_rounded,
                    color: textMaroon,
                  ),
                  text: 'Rate The App',
                  onTap: () {
                    //Navigator.pop(context);
                    onRatingPressed(context);
                  }),
              BuildDrawerBodyItem(
                  icon: Icon(
                      Icons.share_rounded,
                    color: textBlue,
                  ),
                  text: 'Share',
                  onTap: () {
                    Share.share('Hey check out this android app $appLink');
                  }),
              Divider(),
              BuildDrawerBodyItem(
                  icon: Icon(
                    Icons.shop_rounded,
                    color: textAmber,
                  ),
                  text: 'Other Apps',
                  onTap: () async {
                    if (await canLaunch(storeLink)) {
                      await launch(storeLink);
                    } else {
                      throw 'Could not launch $storeLink';
                    }
                  }),
              BuildDrawerBodyItem(
                  icon: Icon(
                      Icons.contact_mail,
                      color: textMaroon,
                  ),
                  text: 'Send E-mail',
                  onTap: () async {
                    if (await canLaunch(contactMail)) {
                      await launch(contactMail);
                    } else {
                      throw 'Could not launch $contactMail';
                    }
                  }),
              BuildDrawerBodyItem(
                  icon: Icon(
                    Icons.android_rounded,
                    color: textBlue,
                  ),
                  text: 'About',
                  onTap: () async {
                    Navigator.pushNamed(context, aboutPage);
                  }),
              Divider(),
              BuildDrawerBodyItem(
                  icon: Icon(
                    Icons.update,
                    color: textOrange,
                  ),
                  text: 'Check For Update',
                  onTap: () async {
                    Navigator.pushNamed(context, updateCheckPage);
                  }),
              BuildDrawerBodyItem(
                  icon: Icon(
                    Icons.verified_user_rounded,
                    color: textMaroon,
                  ),
                  text: 'Version ${getAppVersion()}',
                  onTap: null
              ),
            ],
          ),
        ),
      ),
    );
  }
}
