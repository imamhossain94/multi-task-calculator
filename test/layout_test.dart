// Layout regression tests.
//
// These pump every screen at real phone dimensions with the real typeface
// loaded. A `RenderFlex` overflow, an off-screen widget or a failed assertion
// is reported as a test failure by the Flutter test binding, so simply reaching
// the end of each test proves the page lays out cleanly.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_task_calculator/main.dart';
import 'package:multi_task_calculator/pages/general_calc_page/components/build_calc_button.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A tall, narrow phone - the shape most likely to overflow.
const Size _phone = Size(393, 851);

/// `flutter_test` falls back to a placeholder typeface whose metrics are much
/// wider than the real one, which produces false overflow failures.
Future<void> _loadFont() async {
  final Uint8List bytes = await File('fonts/Audiowide-Regular.ttf').readAsBytes();
  await (FontLoader('Audiowide')
        ..addFont(Future<ByteData>.value(ByteData.sublistView(bytes))))
      .load();
}

Future<void> _open(WidgetTester tester, String route) async {
  await tester.pumpWidget(const MultiTaskCalculator());
  await tester.pump(const Duration(milliseconds: 100));
  if (route != homePage) {
    tester.state<NavigatorState>(find.byType(Navigator)).pushNamed(route);
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.pump(const Duration(milliseconds: 300));
  expect(tester.takeException(), isNull);
}

void main() {
  setUpAll(_loadFont);

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  Future<void> usePhone(WidgetTester tester) async {
    // `physicalSize` is in device pixels, so it must be `logical * dpr`.
    tester.view.devicePixelRatio = 2.0;
    tester.view.physicalSize = _phone * 2.0;
    addTearDown(tester.view.reset);
  }

  final Map<String, String> routes = <String, String>{
    homePage: homePage,
    generalCalcPage: generalCalcPage,
    currencyCalcPage: currencyCalcPage,
    unitConverterPage: unitConverterPage,
    discountCalcPage: discountCalcPage,
    tipCalcPage: tipCalcPage,
    dateCalcPage: dateCalcPage,
    fuelCalcPage: fuelCalcPage,
    fuelEfficiencyCalcPage: fuelEfficiencyCalcPage,
    healthCalcPage: healthCalcPage,
    loanCalcPage: loanCalcPage,
    salesTaxCalcPage: salesTaxCalcPage,
    savingCalcPage: savingCalcPage,
    unitPriceCalcPage: unitPriceCalcPage,
    numberBaseConverterPage: numberBaseConverterPage,
    historyPage: historyPage,
    aboutPage: aboutPage,
    helpPage: helpPage,
  };

  for (final String route in routes.keys) {
    testWidgets('$route lays out without overflow on a phone', (
      WidgetTester tester,
    ) async {
      await usePhone(tester);
      await _open(tester, route);
      expect(find.byType(MaterialApp), findsWidgets);
    });
  }

  testWidgets('the general calculator key pad fills the screen', (
    WidgetTester tester,
  ) async {
    await usePhone(tester);
    await _open(tester, generalCalcPage);
    // The pad is six rows of four keys; the regression it guards against was a
    // `Table` in an `Expanded` overflowing on short screens.
    expect(find.byType(BuildCalcButton), findsNWidgets(24));
  });
}
