import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../../utils/screen_config.dart';
import '../../../components/app_surface.dart' show appBorder;
import '../../../utils/themes_mode.dart';
import '../../../components/app_surface.dart';
import '../../../utils/app_color.dart';

/// A single calculator tile on the home screen.
///
/// Flat and outlined: a plain surface with a hairline border, a solid square
/// of the tool's accent for the icon, and no shadow.
class BuildHomeMenuButton extends StatelessWidget {
  const BuildHomeMenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemesMode.isDarkMode;

    // Deliberately *not* wrapped in `Expanded`: this widget is used as a
    // `GridView` child, where the grid already controls sizing and an
    // `Expanded` parent-data widget would throw at runtime.
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadii.allMd,
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: ThemesMode.surface,
              borderRadius: AppRadii.allMd,
              border: appBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.sm + 2, horizontal: AppSpacing.xs),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: AppRadii.allMd,
                    ),
                    child: Icon(icon, color: Colors.white, size: 21),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Flexible(
                    child: FittedBox(
                      // Long labels ("Fuel Efficiency") shrink rather than
                      // pushing the icon out of the tile.
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: responsiveText(12),
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                          color: isDark
                              ? ThemesMode.onSurface
                              : AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tiles shown on the home screen, in display order.
class HomeMenuEntry {
  const HomeMenuEntry({
    required this.title,
    required this.icon,
    required this.route,
    required this.palette,
  });

  final String title;
  final IconData icon;
  final String route;
  final ToolPalette palette;
}

const List<HomeMenuEntry> homeMenuEntries = <HomeMenuEntry>[
  HomeMenuEntry(
    title: 'General',
    icon: Icons.calculate_rounded,
    route: generalCalcPage,
    palette: AppPalettes.general,
  ),
  HomeMenuEntry(
    title: 'Currency',
    icon: Icons.currency_exchange_rounded,
    route: currencyCalcPage,
    palette: AppPalettes.currency,
  ),
  HomeMenuEntry(
    title: 'Unit Converter',
    icon: Icons.swap_horiz_rounded,
    route: unitConverterPage,
    palette: AppPalettes.unitConverter,
  ),
  HomeMenuEntry(
    title: 'Discount',
    icon: Icons.percent_rounded,
    route: discountCalcPage,
    palette: AppPalettes.discount,
  ),
  HomeMenuEntry(
    title: 'Tip',
    icon: Icons.receipt_rounded,
    route: tipCalcPage,
    palette: AppPalettes.tip,
  ),
  HomeMenuEntry(
    title: 'Date',
    icon: Icons.event_rounded,
    route: dateCalcPage,
    palette: AppPalettes.date,
  ),
  HomeMenuEntry(
    title: 'Fuel Cost',
    icon: Icons.local_gas_station_rounded,
    route: fuelCalcPage,
    palette: AppPalettes.fuelCost,
  ),
  HomeMenuEntry(
    title: 'Fuel Efficiency',
    icon: Icons.eco_rounded,
    route: fuelEfficiencyCalcPage,
    palette: AppPalettes.fuelEfficiency,
  ),
  HomeMenuEntry(
    title: 'Health',
    icon: Icons.favorite_rounded,
    route: healthCalcPage,
    palette: AppPalettes.health,
  ),
  HomeMenuEntry(
    title: 'Loan',
    icon: Icons.account_balance_rounded,
    route: loanCalcPage,
    palette: AppPalettes.loan,
  ),
  HomeMenuEntry(
    title: 'Sales Tax',
    icon: Icons.receipt_long_rounded,
    route: salesTaxCalcPage,
    palette: AppPalettes.salesTax,
  ),
  HomeMenuEntry(
    title: 'Savings',
    icon: Icons.savings_rounded,
    route: savingCalcPage,
    palette: AppPalettes.savings,
  ),
  HomeMenuEntry(
    title: 'Unit Price',
    icon: Icons.balance_rounded,
    route: unitPriceCalcPage,
    palette: AppPalettes.unitPrice,
  ),
  HomeMenuEntry(
    title: 'Number Base',
    icon: Icons.tag_rounded,
    route: numberBaseConverterPage,
    palette: AppPalettes.numberBase,
  ),
];
