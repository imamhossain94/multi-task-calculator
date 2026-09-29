import 'package:flutter/material.dart';
import '../../services/google_ad_service.dart';

import '../../components/build_result_card.dart';
import '../../components/build_text_field.dart';
import '../../components/calculator_scaffold.dart';
import '../../services/history_service.dart';
import '../../utils/app_color.dart';
import '../../utils/calculator_math.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import '../../utils/num_x.dart';
class FuelCostCalcPage extends StatefulWidget {
  const FuelCostCalcPage({super.key});

  @override
  State<FuelCostCalcPage> createState() => _FuelCostCalcPageState();
}

class _FuelCostCalcPageState extends State<FuelCostCalcPage> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _efficiencyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  double _litres = 0;
  double _cost = 0;
  bool _hasInput = false;

  static const ToolPalette _palette = AppPalettes.fuelCost;

  @override
  void initState() {
    super.initState();
    _distanceController.addListener(_recalculate);
    _efficiencyController.addListener(_recalculate);
    _priceController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _efficiencyController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _recalculate() {
    final double distance = double.tryParse(_distanceController.text) ?? 0;
    final double efficiency =
        double.tryParse(_efficiencyController.text) ?? 0;
    final double price = double.tryParse(_priceController.text) ?? 0;

    // Efficiency must be > 0 or the result is `Infinity`. Require both a real
    // distance and a real efficiency before showing anything.
    if (distance <= 0 || efficiency <= 0) {
      if (_hasInput || _litres != 0 || _cost != 0) {
        setState(() {
          _hasInput = false;
          _litres = 0;
          _cost = 0;
        });
      }
      return;
    }

    final ({double litres, double cost}) result = fuelCost(
      distanceKm: distance,
      efficiencyKmPerLitre: efficiency,
      pricePerLitre: price,
    );

    setState(() {
      _hasInput = true;
      _litres = result.litres;
      _cost = result.cost;
    });

    _maybeSave(distance, efficiency, price);
  }

  String? _lastSaved;
  void _maybeSave(double distance, double efficiency, double price) {
    final String signature =
        '$distance|$efficiency|$price|${_litres.toStringAsFixed(4)}';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Fuel Cost',
        toolRoute: fuelCalcPage,
        summary:
            '${NumX.format(distance)} km @ ${NumX.format(efficiency, decimals: 1)} km/l '
            '= ${NumX.money(_cost)} (${NumX.format(_litres, decimals: 3)} l)',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _reset() async {
    await showInterstitialAd();
    if (!mounted) return;
    resetPage(context, const FuelCostCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Fuel Cost Calculator',
      icon: Icons.local_gas_station_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BuildTextField(
                title: 'Distance to Travel',
                hint: '0.00',
                isEnabled: true,
                textController: _distanceController,
                palette: _palette,
                onPressedAction: null,
                widget: const Text('km'),
              ),
              BuildTextField(
                title: 'Fuel Efficiency',
                hint: '0.00',
                isEnabled: true,
                textController: _efficiencyController,
                palette: _palette,
                onPressedAction: null,
                widget: const Text('km/l'),
              ),
              BuildTextField(
                title: 'Fuel Price',
                hint: '0.00',
                isEnabled: true,
                textController: _priceController,
                palette: _palette,
                onPressedAction: null,
                widget: const Text(r'$/l'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'Estimated Cost',
              numeric: _cost,
              prefix: r'$',
              palette: _palette,
              icon: Icons.payments_rounded,
            ),
            BuildResultCard(
              title: 'Fuel Needed',
              numeric: _litres,
              decimals: 3,
              suffix: ' l',
              palette: _palette,
              icon: Icons.water_drop_rounded,
            ),
          ],
        ),
        if (!_hasInput)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              'Enter a distance and a fuel efficiency above 0 to see the cost.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
