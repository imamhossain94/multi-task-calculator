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

class FuelEfficiencyCalcPage extends StatefulWidget {
  const FuelEfficiencyCalcPage({super.key});

  @override
  State<FuelEfficiencyCalcPage> createState() => _FuelEfficiencyCalcPageState();
}

class _FuelEfficiencyCalcPageState extends State<FuelEfficiencyCalcPage> {
  final TextEditingController _beforeController = TextEditingController();
  final TextEditingController _litresController = TextEditingController();
  final TextEditingController _afterController = TextEditingController();

  double _efficiency = 0;
  double _distance = 0;
  bool _hasInput = false;

  static const ToolPalette _palette = AppPalettes.fuelEfficiency;

  @override
  void initState() {
    super.initState();
    _beforeController.addListener(_recalculate);
    _litresController.addListener(_recalculate);
    _afterController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _beforeController.dispose();
    _litresController.dispose();
    _afterController.dispose();
    super.dispose();
  }

  void _recalculate() {
    final double before = double.tryParse(_beforeController.text) ?? 0;
    final double litres = double.tryParse(_litresController.text) ?? 0;
    final double after = double.tryParse(_afterController.text) ?? 0;

    // Needs a non-zero fill and a positive distance travelled. Anything else
    // used to divide by zero and render `Infinity`.
    if (litres <= 0 || after <= before) {
      if (_hasInput || _efficiency != 0) {
        setState(() {
          _hasInput = false;
          _efficiency = 0;
          _distance = 0;
        });
      }
      return;
    }

    final double distance = after - before;
    final double efficiency = fuelEfficiency(
        startOdometer: before, endOdometer: after, litres: litres);

    setState(() {
      _hasInput = true;
      _distance = distance;
      _efficiency = efficiency;
    });

    _maybeSave(before, after, litres);
  }

  String? _lastSaved;
  void _maybeSave(double before, double after, double litres) {
    final String signature = '$before|$after|$litres';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Fuel Efficiency',
        toolRoute: fuelEfficiencyCalcPage,
        summary:
            '${NumX.format(_distance)} km on ${NumX.format(litres, decimals: 2)} l '
            '= ${NumX.format(_efficiency, decimals: 2)} km/l',
        createdAt: DateTime.now(),
      ),
    );
  }

  void _reset() {
    resetPage(context, const FuelEfficiencyCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Fuel Efficiency',
      icon: Icons.eco_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppInputCard(
          children: <Widget>[
            BuildTextField(
              title: 'Odometer Before Refuelling',
              hint: '0.00',
              isEnabled: true,
              textController: _beforeController,
              palette: _palette,
              onPressedAction: null,
              widget: const Text('km'),
            ),
            BuildTextField(
              title: 'Fuel Added',
              hint: '0.00',
              isEnabled: true,
              textController: _litresController,
              palette: _palette,
              onPressedAction: null,
              widget: const Text('l'),
            ),
            BuildTextField(
              title: 'Odometer After Driving',
              hint: '0.00',
              isEnabled: true,
              textController: _afterController,
              palette: _palette,
              onPressedAction: null,
              widget: const Text('km'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'Distance Travelled',
              numeric: _distance,
              decimals: 1,
              suffix: ' km',
              palette: _palette,
              icon: Icons.route_rounded,
            ),
            BuildResultCard(
              title: 'Efficiency',
              numeric: _efficiency,
              decimals: 2,
              suffix: ' km/l',
              palette: _palette,
              icon: Icons.eco_rounded,
            ),
          ],
        ),
        if (!_hasInput)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
            child: Text(
              'Fill the tank, drive, then enter the fuel added and both '
              'odometer readings.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
            child: Text(
              'That is ${NumX.format(NumX.divide(100, _efficiency, 0), decimals: 1)} l '
              'per 100 km.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
