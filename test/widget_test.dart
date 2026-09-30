// Smoke tests: the app builds and the home screen renders its calculator grid.

import 'package:flutter_test/flutter_test.dart';
import 'package:multi_task_calculator/main.dart';
import 'package:multi_task_calculator/pages/home_page/components/build_home_menu_button.dart';
import 'package:multi_task_calculator/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    // `main()` reads the saved theme through SharedPreferences, so provide an
    // in-memory implementation before pumping the widget tree.
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  testWidgets('app starts and renders the home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MultiTaskCalculator());
    await tester.pump();

    expect(find.text(appName), findsWidgets);
    // The calculator grid is present.
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Loan'), findsOneWidget);
  });

  test('every home entry has a unique, non-empty route', () {
    final Set<String> routes = <String>{};
    for (final HomeMenuEntry entry in homeMenuEntries) {
      expect(entry.title, isNotEmpty);
      expect(entry.route, isNotEmpty);
      expect(
        routes.add(entry.route),
        isTrue,
        reason: 'duplicate route for ${entry.title}',
      );
    }
    expect(homeMenuEntries.length, greaterThanOrEqualTo(13));
  });
}
