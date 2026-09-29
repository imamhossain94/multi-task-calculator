import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/about_page.dart';
import '../pages/currency_calc_page/currency_calc_page.dart';
import '../pages/date_calc/date_calc_page.dart';
import '../pages/discount_calc/discount_calc_page.dart';
import '../pages/feedback_page.dart';
import '../pages/fuel_calc/fuel_cost_calc_page.dart';
import '../pages/fuel_calc/fuel_efficiency_calc_page.dart';
import '../pages/general_calc_page/general_calc_page.dart';
import '../pages/health_calc/health_calc_page.dart';
import '../pages/help_page.dart';
import '../pages/history_page.dart';
import '../pages/home_page/home_page.dart';
import '../pages/loan_calc/loan_calc_page.dart';
import '../pages/premium_page.dart';
import '../pages/sales_tax_calc/sales_tax_calc_page.dart';
import '../pages/savings_calc/savings_calc_page.dart';
import '../pages/tip_calc/tip_calc_page.dart';
import '../pages/unit_converter/number_base_converter_page.dart';
import '../pages/unit_converter/unit_converter_child_page.dart';
import '../pages/unit_converter/unit_converter_page.dart';
import '../pages/unit_price_calc/unit_price_calc_page.dart';
import '../pages/update_check_page.dart';
import 'constant.dart';

/// Single place that maps a route name onto its page.
///
/// Returning a real [PageRoute] for unknown names (instead of `null`) means a
/// bad deep link lands on a readable error screen rather than crashing.
Route<dynamic>? generateRoute(RouteSettings settings) {
  final String? name = settings.name;
  if (name == null) return null;

  switch (name) {
    // ---------------------------------------------------------- app screens
    case homePage:
      return _fade(HomePage(), settings);
    case aboutPage:
      return _fade(AboutPage(), settings);
    case feedbackPage:
      return _fade(FeedbackPage(), settings);
    case helpPage:
      return _fade(HelpPage(), settings);
    case updateCheckPage:
      return _fade(const UpdateCheckPage(), settings);
    case historyPage:
      return _fade(const HistoryPage(), settings);
    case premiumPage:
      return _fade(const PremiumPage(), settings);

    // ---------------------------------------------------------- calculators
    case generalCalcPage:
      return _fade(GeneralCalcPage(), settings);
    case currencyCalcPage:
      return _fade(CurrencyCalcPage(), settings);
    case discountCalcPage:
      return _fade(DiscountCalcPage(), settings);
    case tipCalcPage:
      return _fade(TipCalcPage(), settings);
    case dateCalcPage:
      return _fade(DateCalcPage(), settings);
    case fuelCalcPage:
      return _fade(FuelCostCalcPage(), settings);
    case fuelEfficiencyCalcPage:
      return _fade(FuelEfficiencyCalcPage(), settings);
    case healthCalcPage:
      return _fade(HealthCalcPage(), settings);
    case loanCalcPage:
      return _fade(LoanCalcPage(), settings);
    case salesTaxCalcPage:
      return _fade(SalesTaxCalcPage(), settings);
    case savingCalcPage:
      return _fade(SavingsCalcPage(), settings);
    case unitPriceCalcPage:
      return _fade(UnitPriceCalcPage(), settings);

    // ------------------------------------------------------ unit converters
    case unitConverterPage:
      return _slide(UnitConverterPage(), settings);
    case unitConverterChildPage:
      return _fade(UnitConverterChildPage(arguments: settings.arguments), settings);
    case numberBaseConverterPage:
      return _fade(NumberBaseConverterPage(), settings);

    default:
      return _fade(_UnknownRoutePage(name: name), settings);
  }
}

PageRoute<dynamic> _fade(Widget child, RouteSettings settings) => PageTransition(
      child: child,
      type: PageTransitionType.fade,
      settings: settings,
    );

PageRoute<dynamic> _slide(Widget child, RouteSettings settings) => PageTransition(
      child: child,
      type: PageTransitionType.rightToLeft,
      settings: settings,
    );

class _UnknownRoutePage extends StatelessWidget {
  const _UnknownRoutePage({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.explore_off_rounded, size: 48),
              const SizedBox(height: 12),
              Text('No page is registered for "$name".'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    Navigator.of(context).pushNamedAndRemoveUntil(homePage, (_) => false),
                child: const Text('Back to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
