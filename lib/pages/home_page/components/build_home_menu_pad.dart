import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_home_menu_button.dart';
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
            onPressed: () => Navigator.pushNamed(context, generalCalcPage),
            color: textRed,
          ),
          BuildHomeMenuButton(
            title: 'Currency',
            icon: FontAwesomeIcons.funnelDollar,
            onPressed: ()=> Navigator.pushNamed(context, currencyCalcPage),
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Unit Converter',
            icon: FontAwesomeIcons.tag,
            onPressed: ()=> Navigator.pushNamed(context, unitConverterPage),
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Discount',
            icon: FontAwesomeIcons.percentage,
            onPressed: ()=> Navigator.pushNamed(context, discountCalcPage),
            color: textRed,
          ),
          BuildHomeMenuButton(
            title: 'Tip',
            icon: FontAwesomeIcons.wallet,
            onPressed: ()=> Navigator.pushNamed(context, tipCalcPage),
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Date',
            icon: FontAwesomeIcons.calendarAlt,
            onPressed: ()=> Navigator.pushNamed(context, dateCalcPage),
            color: textMaroon,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Fuel Cost',
            icon: FontAwesomeIcons.gasPump,
            onPressed: ()=> Navigator.pushNamed(context, fuelCalcPage),
            color: textYellow,
          ),
          BuildHomeMenuButton(
            title: 'Fuel Efficiency',
            icon: FontAwesomeIcons.commentDollar,
            onPressed: ()=> Navigator.pushNamed(context, fuelEfficiencyCalcPage),
            color: textRed,
          ),
          BuildHomeMenuButton(
            title: 'Health',
            icon: FontAwesomeIcons.heartbeat,
            onPressed: ()=> Navigator.pushNamed(context, healthCalcPage),
            color: textOrange,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Loan',
            icon: FontAwesomeIcons.landmark,
            onPressed: () async{
              if (await canLaunch(loanAppLink)) {
                await launch(loanAppLink);
              } else {
                throw 'Could not launch $appLink';
              }
            },
            color: textBlue,
          ),
          BuildHomeMenuButton(
            title: 'Sales Tax',
            icon: FontAwesomeIcons.fileInvoiceDollar,
            onPressed: ()=> Navigator.pushNamed(context, salesTaxCalcPage),
            color: textGreen,
          ),
          BuildHomeMenuButton(
            title: 'Savings',
            icon: FontAwesomeIcons.coins,
            onPressed: () {},
            color: textAmber,
          ),
        ]),
        Row(children: <Widget>[
          BuildHomeMenuButton(
            title: 'Unit Price',
            icon: FontAwesomeIcons.balanceScale,
            onPressed: ()=> Navigator.pushNamed(context, unitPriceCalcPage),
            color: textGreen,
          ),
        ]),
      ]),
    );
  }
}
