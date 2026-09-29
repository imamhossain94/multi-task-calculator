import 'package:flutter/material.dart';
import '../../services/google_ad_service.dart';

import '../../components/build_result_card.dart';
import '../../components/build_text_field.dart';
import '../../components/calculator_scaffold.dart';
import '../../utils/app_color.dart';
import '../../utils/calculator_math.dart';
import '../../utils/extensions.dart';
import '../../utils/num_x.dart';
class DiscountCalcPage extends StatefulWidget {
  const DiscountCalcPage({super.key});

  @override
  State<DiscountCalcPage> createState() => _DiscountCalcPageState();
}

class _DiscountCalcPageState extends State<DiscountCalcPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  double _amountSaved = 0;
  double _finalPrice = 0;

  bool _hasInput = false;

  static const ToolPalette _palette = AppPalettes.discount;

  @override
  void initState() {
    super.initState();
    _priceController.addListener(_recalculate);
    _taxController.addListener(_recalculate);
    _discountController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _priceController.dispose();
    _taxController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _recalculate() {
    final double price = double.tryParse(_priceController.text) ?? 0;
    final double tax = double.tryParse(_taxController.text) ?? 0;
    final double off = double.tryParse(_discountController.text) ?? 0;

    // Recalculating on every keystroke left the previous result on screen when
    // a field was cleared; reset the flag whenever the price is emptied.
    final bool hasInput = price > 0;

    if (!hasInput) {
      if (_hasInput || _amountSaved != 0 || _finalPrice != 0) {
        setState(() {
          _hasInput = false;
          _amountSaved = 0;
          _finalPrice = 0;
        });
      }
      return;
    }

    final ({double saved, double finalPrice}) result = discount(
      originalPrice: price,
      taxPercent: tax,
      discountPercent: off,
    );

    setState(() {
      _hasInput = true;
      _amountSaved = result.saved;
      _finalPrice = result.finalPrice;
    });
  }

  Future<void> _reset() async {
    await showInterstitialAd();
    if (!mounted) return;
    resetPage(context, const DiscountCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Discount Calculator',
      icon: Icons.percent_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        _InputCard(
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
              title: 'Added Tax',
              hint: '0.00',
              isEnabled: true,
              textController: _taxController,
              palette: _palette,
              onPressedAction: null,
              widget: const Text('%'),
            ),
            BuildTextField(
              title: 'Discount',
              hint: '0.00',
              isEnabled: true,
              textController: _discountController,
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
              title: 'Amount Saved',
              numeric: _amountSaved,
              prefix: r'$',
              palette: _palette,
              icon: Icons.savings_rounded,
            ),
            BuildResultCard(
              title: 'Final Price',
              numeric: _finalPrice,
              prefix: r'$',
              palette: _palette,
              icon: Icons.sell_rounded,
            ),
          ],
        ),
        if (_hasInput)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              'Tax is applied first, then the discount. '
              'You save ${NumX.percentText(NumX.percent(_amountSaved, _finalPrice + _amountSaved))} of what you pay.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

/// Neutral surface that groups the input fields.
class _InputCard extends StatelessWidget {
  const _InputCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}