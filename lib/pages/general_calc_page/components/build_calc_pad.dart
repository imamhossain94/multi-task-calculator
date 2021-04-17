import 'package:flutter/material.dart';
import 'package:multi_task_calculator/pages/general_calc_page/components/build_calc_button.dart';
import 'package:multi_task_calculator/utils/constant.dart';

class BuildCalcPad extends StatelessWidget {
  BuildCalcPad({
    @required this.onPressed,
  });
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
            children: [
              BuildCalcButton(
                title: '\u22ef',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('more');
                },
              ),
              BuildCalcButton(
                title: '(',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('(');
                },
              ),
              BuildCalcButton(
                title: ')',
                textColor: textMaroon,
                onPressed: () {
                  onPressed(')');
                },
              ),
              BuildCalcButton(
                title: '\u232b',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('del');
                },
              ),
            ]
        ),
        TableRow(
            children: [
              BuildCalcButton(
                title: 'C',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('C');
                },
              ),
              BuildCalcButton(
                title: '%',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('%');
                },
              ),
              BuildCalcButton(
                title: 'x\u207f',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('^');
                },
              ),
              BuildCalcButton(
                title: '÷',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('÷');
                },
              ),
            ]
        ),
        TableRow(
            children: [
              BuildCalcButton(
                title: '7',
                onPressed: () {
                  onPressed('7');
                },
              ),
              BuildCalcButton(
                title: '8',
                onPressed: () {
                  onPressed('8');
                },
              ),
              BuildCalcButton(
                title: '9',
                onPressed: () {
                  onPressed('9');
                },
              ),
              BuildCalcButton(
                title: '×',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('×');
                },
              ),
            ]
        ),
        TableRow(
            children: [
              BuildCalcButton(
                title: '4',
                onPressed: () {
                  onPressed('4');
                },
              ),
              BuildCalcButton(
                title: '5',
                onPressed: () {
                  onPressed('5');
                },
              ),
              BuildCalcButton(
                title: '6',
                onPressed: () {
                  onPressed('6');
                },
              ),
              BuildCalcButton(
                title: '–',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('–');
                },
              ),
            ]
        ),
        TableRow(
            children: [
              BuildCalcButton(
                title: '1',
                onPressed: () {
                  onPressed('1');
                },
              ),
              BuildCalcButton(
                title: '2',
                onPressed: () {
                  onPressed('2');
                },
              ),
              BuildCalcButton(
                title: '3',
                onPressed: () {
                  onPressed('3');
                },
              ),
              BuildCalcButton(
                title: '+',
                textColor: textMaroon,
                onPressed: () {
                  onPressed('+');
                },
              ),
            ]
        ),
        TableRow(
            children: [
              BuildCalcButton(
                title: '0',
                onPressed: () {
                  onPressed('0');
                },
              ),
              BuildCalcButton(
                title: '00',
                onPressed: () {
                  onPressed('00');
                },
              ),
              BuildCalcButton(
                title: '.',
                onPressed: () {
                  onPressed('.');
                },
              ),
              BuildCalcButton(
                title: '=',
                buttonColor: textGreen,
                textColor: textWhite,
                onPressed: () {
                  onPressed('=');
                },
              ),
            ]
        ),
      ],
    );
  }
}
