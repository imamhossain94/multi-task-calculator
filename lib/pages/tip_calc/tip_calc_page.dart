import 'package:flutter/material.dart';

import '../../components/build_result_card.dart';
import '../../components/build_text_field.dart';
import '../../components/calculator_scaffold.dart';
import '../../services/history_service.dart';
import '../../utils/calculator_math.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import '../../utils/num_x.dart';
import '../../utils/app_color.dart';
import '../../components/app_surface.dart';

class TipCalcPage extends StatefulWidget {
  const TipCalcPage({super.key});

  @override
  State<TipCalcPage> createState() => _TipCalcPageState();
}

class _TipCalcPageState extends State<TipCalcPage> {
  final TextEditingController _billController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _tipController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();

  /// Whether the tip input is an absolute amount (`true`) or a percentage.
  bool _tipIsAmount = true;

  /// Whether the tax input is an absolute amount (`true`) or a percentage.
  bool _taxIsAmount = true;

  double _tip = 0;
  double _tax = 0;
  double _finalAmount = 0;
  double _perPerson = 0;
  bool _hasInput = false;

  static const ToolPalette _palette = AppPalettes.tip;

  @override
  void initState() {
    super.initState();
    for (final TextEditingController c in <TextEditingController>[
      _billController,
      _peopleController,
      _tipController,
      _taxController,
    ]) {
      c.addListener(_recalculate);
    }
  }

  @override
  void dispose() {
    _billController.dispose();
    _peopleController.dispose();
    _tipController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  Future<void> _recalculate() async {
    final double bill = double.tryParse(_billController.text) ?? 0;
    final int people = int.tryParse(_peopleController.text) ?? 0;
    final double tipInput = double.tryParse(_tipController.text) ?? 0;
    final double taxInput = double.tryParse(_taxController.text) ?? 0;

    if (bill <= 0) {
      if (_hasInput) _clear();
      return;
    }

    final ({
      double tip,
      double tax,
      double finalAmount,
      double perPerson
    }) result = tip(
      bill: bill,
      tipInput: tipInput,
      taxInput: taxInput,
      people: people,
      tipIsPercent: !_tipIsAmount,
      taxIsPercent: !_taxIsAmount,
    );

    setState(() {
      _hasInput = true;
      _tip = result.tip;
      _tax = result.tax;
      _finalAmount = result.finalAmount;
      _perPerson = result.perPerson;
    });

    await _maybeSave(bill, people, result.finalAmount, result.perPerson);
  }

  void _clear() {
    setState(() {
      _hasInput = false;
      _tip = 0;
      _tax = 0;
      _finalAmount = 0;
      _perPerson = 0;
    });
  }

  String? _lastSaved;
  Future<void> _maybeSave(
      double bill, int people, double total, double each) async {
    final String signature = '$bill|$people|$total|$each|$_tipIsAmount|'
        '$_taxIsAmount|${_tipController.text}|${_taxController.text}';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    await HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Tip',
        toolRoute: tipCalcPage,
        summary: '${NumX.money(bill)} bill, tip ${NumX.money(_tip)}, '
            'tax ${NumX.money(_tax)} = ${NumX.money(total)} '
            '(${NumX.money(each)} each for ${people < 1 ? 1 : people})',
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Flips the tip input between an absolute amount and a percentage of the
  /// bill, converting the current value so the result never jumps.
  void _toggleTipMode() {
    final double bill = double.tryParse(_billController.text) ?? 0;
    final double current = double.tryParse(_tipController.text) ?? 0;

    final double converted = _tipIsAmount
        ? NumX.percent(current, bill) // $ -> %
        : bill * (current / 100); // % -> $

    setState(() {
      _tipIsAmount = !_tipIsAmount;
      _tipController.text = _formatForInput(converted);
    });
  }

  /// Flips the tax input between an absolute amount and a percentage.
  void _toggleTaxMode() {
    final double bill = double.tryParse(_billController.text) ?? 0;
    final double current = double.tryParse(_taxController.text) ?? 0;

    final double converted = _taxIsAmount
        ? NumX.percent(current, bill) // $ -> %
        : bill * (current / 100); // % -> $

    setState(() {
      _taxIsAmount = !_taxIsAmount;
      _taxController.text = _formatForInput(converted);
    });
  }

  static String _formatForInput(double value) =>
      value == 0 ? '' : value.toStringAsFixed(2);

  /// Switches the tip into percentage mode and sets it to [percent].
  void _applyTipPreset(int percent) {
    if (!mounted) return;
    setState(() {
      _tipIsAmount = false;
      _tipController.text = percent.toString();
    });
  }

  void _reset() {
    resetPage(context, const TipCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Tip Calculator',
      icon: Icons.receipt_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppInputCard(
          children: <Widget>[
            BuildTextField(
              title: 'Bill Amount',
              hint: '0.00',
              isEnabled: true,
              textController: _billController,
              palette: _palette,
              onPressedAction: null,
              widget: const Text(r'$'),
            ),
            BuildTextField(
              title: 'Tax Amount',
              hint: '0.00',
              isEnabled: true,
              textController: _taxController,
              palette: _palette,
              onPressedAction: _toggleTaxMode,
              widget: Text(_taxIsAmount ? r'$' : '%'),
            ),
            BuildTextField(
              title: 'Tip Amount',
              hint: '0.00',
              isEnabled: true,
              textController: _tipController,
              palette: _palette,
              onPressedAction: _toggleTipMode,
              widget: Text(_tipIsAmount ? r'$' : '%'),
            ),
            BuildTextField(
              title: 'Split Between',
              hint: '1',
              isEnabled: true,
              textController: _peopleController,
              palette: _palette,
              onPressedAction: null,
              widget: const Icon(Icons.group_rounded, size: 19),
            ),
            _QuickTipRow(onSelected: _applyTipPreset),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'Final Amount',
              numeric: _finalAmount,
              prefix: r'$',
              palette: _palette,
              icon: Icons.receipt_long_rounded,
            ),
            BuildResultCard(
              title: 'Each Person Pays',
              numeric: _perPerson,
              prefix: r'$',
              palette: _palette,
              icon: Icons.group_rounded,
            ),
          ],
        ),
        if (_hasInput)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
            child: Text(
              'Bill ${NumX.money(_finalAmount - _tip - _tax)}'
              '${_tax > 0 ? ' + tax ${NumX.money(_tax)}' : ''}'
              '${_tip > 0 ? ' + tip ${NumX.money(_tip)}' : ''}'
              ' = ${NumX.money(_finalAmount)}.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

/// One-tap 10 / 15 / 20 / 25 % shortcuts.
class _QuickTipRow extends StatelessWidget {
  const _QuickTipRow({required this.onSelected});

  final ValueChanged<int> onSelected;

  static const List<int> presets = <int>[10, 15, 20, 25];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 2),
      child: Row(
        children: presets.map((int preset) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: AppRadii.allSm,
                  onTap: () => onSelected(preset),
                  child: Container(
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppPalettes.tip.accent.withValues(alpha: 0.12),
                      borderRadius: AppRadii.allSm,
                    ),
                    child: Text(
                      '$preset%',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }
}
