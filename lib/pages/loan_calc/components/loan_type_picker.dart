import 'package:flutter/material.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class LoanTypePicker extends StatefulWidget {
  final String title;
  final ValueChanged<String> valueChanged;

  LoanTypePicker({
    @required this.title,
    @required this.valueChanged,
  });

  @override
  _LoanTypePickerState createState() => _LoanTypePickerState();
}

class _LoanTypePickerState extends State<LoanTypePicker> {
  bool isMonthlyCost, isMaximumLoan;

  @override
  void initState() {
    isMonthlyCost = true;
    isMaximumLoan = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Container(
      margin: EdgeInsets.all(responsiveWidth(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: responsiveText(16), fontWeight: FontWeight.bold),
              ),
              //Spacer(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: responsiveHeight(8), bottom: responsiveHeight(5)),
            child: Row(
              children: [
                buildGenderButton(
                  title: 'Monthly Cost',
                  onPressed: (){
                    setState(() {
                      isMonthlyCost = true;
                      isMaximumLoan = false;
                    });
                    widget.valueChanged('Monthly Cost');
                  },
                  active:isMonthlyCost,
                ),
                SizedBox(
                  width: responsiveWidth(10),
                ),
                buildGenderButton(
                  title: 'Maximum Loan',
                  onPressed: (){
                    setState(() {
                      isMonthlyCost = false;
                      isMaximumLoan = true;
                    });
                    widget.valueChanged('Maximum Loan');
                  },
                  active:isMaximumLoan,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded buildGenderButton({String title, VoidCallback onPressed, bool active}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(5),
            width: responsiveWidth(55),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ThemesMode.isDarkMode?Colors.grey.withOpacity(active ? 0.3 : 0.15):Colors.grey.withOpacity(active ? 0.3 : 0.07),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
                title,
                style: TextStyle(
                    fontSize: responsiveHeight(16),
                    //fontWeight: FontWeight.bold
                )
            )
          ),
        ),
      ),
    );
  }
}
