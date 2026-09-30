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
import 'package:multi_task_calculator/pages/general_calc_page/components/build_display.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A tall, narrow phone - the shape most likely to overflow.
const Size _phone = Size(393, 851);

/// `flutter_test` falls back to a placeholder typeface whose metrics are much
/// wider than the real one, which produces false overflow failures.
Future<void> _loadFont() async {
  final Uint8List bytes =
      await File('fonts/Audiowide-Regular.ttf').readAsBytes();
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

  testWidgets('toggling scientific resizes the display, not the keys', (
    WidgetTester tester,
  ) async {
    await usePhone(tester);
    await _open(tester, generalCalcPage);

    final Rect keysBefore = _padBounds(tester);
    final Size displayBefore = _displaySize(tester);

    // Collapse the scientific row via the "Hide" toggle.
    await tester.tap(find.text('Hide'));
    await tester.pumpAndSettle();

    final Rect keysAfter = _padBounds(tester);
    final Size displayAfter = _displaySize(tester);

    // The keys must not move at all - their height is derived from the width,
    // and the width does not change when the row toggles.
    expect(keysAfter, keysBefore, reason: 'key pad shifted on toggle');

    // The display absorbs the difference, so it must have actually changed.
    expect(
      displayAfter.height,
      isNot(closeTo(displayBefore.height, 1)),
      reason: 'display did not absorb the scientific row height',
    );
    expect(displayAfter.height, greaterThan(displayBefore.height));
  });

  testWidgets('key pad keys are 4:3 and share one gutter with the display', (
    WidgetTester tester,
  ) async {
    await usePhone(tester);
    await _open(tester, generalCalcPage);

    final List<Rect> keys = tester
        .widgetList<BuildCalcButton>(find.byType(BuildCalcButton))
        .map((BuildCalcButton b) => tester.getRect(find.byWidget(b)))
        .toList();
    expect(keys, hasLength(24));

    final double w = keys.first.width;
    final double h = keys.first.height;
    expect(w / h, closeTo(4 / 3, 0.02), reason: 'keys are not 4:3');

    // Every key identical.
    for (final Rect r in keys) {
      expect(r.width, closeTo(w, 0.5));
      expect(r.height, closeTo(h, 0.5));
    }

    // All four rows share the same leading edge, and the columns line up.
    final Set<double> lefts = keys.map((Rect r) => r.left).toSet();
    expect(lefts, hasLength(4));
    final Set<double> tops = keys.map((Rect r) => r.top).toSet();
    expect(tops, hasLength(6));

    // The grid is horizontally centred inside the display card. The bug this
    // guards against sized each key against `columns + 1` gaps but only emitted
    // `columns - 1`, leaving the row short and flush to the left edge.
    final Rect card = tester.getRect(find.byType(BuildDisplay));
    final double insetLeft = keys.first.left - card.left;
    final double insetRight = card.right - keys.last.right;
    expect(
      insetRight,
      closeTo(insetLeft, 0.01),
      reason: 'key pad is not horizontally centred: '
          'left inset $insetLeft, right inset $insetRight',
    );

    // And the outer margin equals the gap between keys.
    final double innerGap = keys[1].left - keys[0].right;
    expect(insetLeft, closeTo(innerGap, 0.01));
  });
}

/// Bounds of the whole key pad, taken from its outermost keys.
Rect _padBounds(WidgetTester tester) {
  final Rect a = tester.getRect(
    find.byWidget(tester.widgetList(find.byType(BuildCalcButton)).first),
  );
  final Rect b = tester.getRect(
    find.byWidget(tester.widgetList(find.byType(BuildCalcButton)).last),
  );
  return a.topLeft & Size(b.right - a.left, b.bottom - a.top);
}

Size _displaySize(WidgetTester tester) =>
    tester.getSize(find.byType(BuildDisplay));
