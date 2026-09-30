import 'package:flutter/material.dart';

import '../../components/build_result_card.dart';
import '../../components/build_text_field.dart';
import '../../components/calculator_scaffold.dart';
import '../../services/history_service.dart';
import '../../utils/calculator_math.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import '../../utils/num_x.dart';
import '../../components/app_surface.dart';
import '../../utils/app_color.dart';

/// Adds a sales tax to a price.
///
/// The previous version divided nothing unguarded but never reset its results,
/// so clearing the price left the last number on screen.
class SalesTaxCalcPage extends StatefulWidget {
  const SalesTaxCalcPage({super.key});

  @override
  State<SalesTaxCalcPage> createState() => _SalesTaxCalcPageState();
}

class _SalesTaxCalcPageState extends State<SalesTaxCalcPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  double _tax = 0;
  double _totalPrice = 0;
  bool _hasInput = false;

  static const ToolPalette _palette = AppPalettes.salesTax;

  @override
  void initState() {
    super.initState();
    _priceController.addListener(_recalculate);
    _rateController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _priceController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _recalculate() {
    final double price = double.tryParse(_priceController.text) ?? 0;
    final double rate = double.tryParse(_rateController.text) ?? 0;

    if (price <= 0) {
      if (_hasInput || _tax != 0 || _totalPrice != 0) {
        setState(() {
          _hasInput = false;
          _tax = 0;
          _totalPrice = 0;
        });
      }
      return;
    }

    final ({double tax, double total}) result =
        salesTax(price: price, ratePercent: rate);
    setState(() {
      _hasInput = true;
      _tax = result.tax;
      _totalPrice = result.total;
    });
    _maybeSave(price, rate, result.tax, result.total);
  }

  String? _lastSaved;
  void _maybeSave(double price, double rate, double tax, double total) {
    final String signature = '$price|$rate';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Sales Tax',
        toolRoute: salesTaxCalcPage,
        summary: '${NumX.money(price)} + ${NumX.percentText(rate)} tax '
            '= ${NumX.money(total)} (tax ${NumX.money(tax)})',
        createdAt: DateTime.now(),
      ),
    );
  }

  void _reset() {
    resetPage(context, const SalesTaxCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Sales Tax Calculator',
      icon: Icons.receipt_long_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppInputCard(
          children: <Widget>[
            BuildTextField(
              title: 'Original Price',
              hint: '0.00',
              isEnabled: true,
              textController: _priceController,
              palette: _palette,
              onPressedAction: null,
              widget: const Text(r'$'),
            ),
            BuildTextField(
              title: 'Tax Rate',
              hint: '0.00',
              isEnabled: true,
              textController: _rateController,
              palette: _palette,
              onPressedAction: null,
              widget: const Text('%'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'Tax Amount',
              numeric: _tax,
              prefix: r'$',
              palette: _palette,
              icon: Icons.account_balance_rounded,
            ),
            BuildResultCard(
              title: 'Total Price',
              numeric: _totalPrice,
              prefix: r'$',
              palette: _palette,
              icon: Icons.shopping_bag_rounded,
            ),
          ],
        ),
        if (_hasInput)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
            child: Text(
              '${NumX.money(_totalPrice - _tax)} + '
              '${NumX.money(_tax)} tax = ${NumX.money(_totalPrice)}.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
