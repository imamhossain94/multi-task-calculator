import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_home_menu_button.dart';
import 'package:multi_task_calculator/services/google_ad_service.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildHomeMenuPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'General',
            icon:FontAwesomeIcons.calculator,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, generalCalcPage);
            },
            color: textMaroon,
          ),
          BuildHomeMenuButton(
            title: 'Currency',
            icon: FontAwesomeIcons.funnelDollar,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, currencyCalcPage);
            },
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Unit Converter',
            icon: FontAwesomeIcons.tag,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, unitConverterPage);
            },
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Discount',
            icon: FontAwesomeIcons.percentage,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, discountCalcPage);
            },
            color: textMaroon,
          ),
          BuildHomeMenuButton(
            title: 'Tip',
            icon: FontAwesomeIcons.wallet,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, tipCalcPage);
            },
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Date',
            icon: FontAwesomeIcons.calendarAlt,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, dateCalcPage);
            },
            color: textMaroon,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Fuel Cost',
            icon: FontAwesomeIcons.gasPump,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, fuelCalcPage);
            },
            color: textYellow,
          ),
          BuildHomeMenuButton(
            title: 'Fuel Efficiency',
            icon: FontAwesomeIcons.commentDollar,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, fuelEfficiencyCalcPage);
            },
            color: textMaroon,
          ),
          BuildHomeMenuButton(
            title: 'Health',
            icon: FontAwesomeIcons.heartbeat,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, healthCalcPage);
            },
            color: textOrange,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Loan',
            icon: FontAwesomeIcons.landmark,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, loanCalcPage);
            },
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Sales Tax',
            icon: FontAwesomeIcons.fileInvoiceDollar,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, salesTaxCalcPage);
            },
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Savings',
            icon: FontAwesomeIcons.coins,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, savingCalcPage);
            },
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Unit Price',
            icon: FontAwesomeIcons.balanceScale,
            onPressed: () async {
              await showInterstitialAd();
              Navigator.pushNamed(context, unitPriceCalcPage);
            },
            color: textGreen,
          ),

        ]),
      ]),
    );
  }
}
