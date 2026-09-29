import 'package:flutter/material.dart';
import '../../services/google_ad_service.dart';

import '../../components/app_surface.dart';
import '../../components/build_result_card.dart';
import '../../components/build_text_field.dart';
import '../../components/calculator_scaffold.dart';
import '../../services/history_service.dart';
import '../../utils/app_color.dart';
import '../../utils/calculator_math.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import '../../utils/num_x.dart';
class SavingsCalcPage extends StatefulWidget {
  const SavingsCalcPage({super.key});

  @override
  State<SavingsCalcPage> createState() => _SavingsCalcPageState();
}

class _SavingsCalcPageState extends State<SavingsCalcPage> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _contributionController =
      TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  int _intervalDays = 30; // Monthly
  String _intervalName = 'Monthly';

  double _balance = 0;
  double _contributed = 0;
  double _interest = 0;
  bool _hasInput = false;

  static const ToolPalette _palette = AppPalettes.savings;

  /// Contribution frequency, in days between deposits.
  static const Map<String, int> _frequencies = <String, int>{
    'Weekly': 7,
    'Bi-Weekly': 14,
    'Monthly': 30,
    'Quarterly': 91,
    'Annually': 364,
  };

  @override
  void initState() {
    super.initState();
    _principalController.addListener(_recalculate);
    _contributionController.addListener(_recalculate);
    _rateController.addListener(_recalculate);
    _yearsController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _principalController.dispose();
    _contributionController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  void _recalculate() {
    final double principal = double.tryParse(_principalController.text) ?? 0;
    final double contribution =
        double.tryParse(_contributionController.text) ?? 0;
    final double rate = double.tryParse(_rateController.text) ?? 0;
    final int years = int.tryParse(_yearsController.text) ?? 0;

    if (rate < 0 || years <= 0) {
      if (_hasInput) _clear();
      return;
    }

    final double balance = savingsProjection(
      principal: principal,
      contribution: contribution,
      annualRatePercent: rate,
      years: years,
      contributionIntervalDays: _intervalDays,
    );
    final double contributed = savingsTotalContributed(
      principal: principal,
      contribution: contribution,
      years: years,
      contributionIntervalDays: _intervalDays,
    );

    setState(() {
      _hasInput = true;
      _balance = balance;
      _contributed = contributed;
      _interest = balance - contributed;
      if (_interest < 0) _interest = 0;
    });

    _maybeSave(principal, contribution, rate, years, balance, contributed);
  }

  void _clear() {
    setState(() {
      _hasInput = false;
      _balance = 0;
      _contributed = 0;
      _interest = 0;
    });
  }

  String? _lastSaved;
  void _maybeSave(
    double principal,
    double contribution,
    double rate,
    int years,
    double balance,
    double contributed,
  ) {
    final String signature =
        '$principal|$contribution|$rate|$years|$_intervalDays';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Savings',
        toolRoute: savingCalcPage,
        summary: '${NumX.money(principal)} + ${NumX.money(contribution)}/$_intervalName '
            '@ ${NumX.percentText(rate, decimals: 2)} for $years yrs '
            '= ${NumX.money(balance)}',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _pickFrequency() async {
    await showAppBottomSheet<void>(
      context: context,
      title: 'Contribution Frequency',
      maxChildSize: 0.7,
      builder: (BuildContext sheetContext, ScrollController controller) {
        return ListView.builder(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          itemCount: _frequencies.length,
          itemBuilder: (BuildContext _, int index) {
            final String name = _frequencies.keys.elementAt(index);
            final int days = _frequencies.values.elementAt(index);
            final bool selected = name == _intervalName;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    setState(() {
                      _intervalName = name;
                      _intervalDays = days;
                    });
                    Navigator.of(sheetContext).pop();
                    _recalculate();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: selected ? _palette.linear : null,
                      color: selected
                          ? null
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: selected
                                ? Colors.white
                                : Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'every $days days',
                          style: TextStyle(
                            fontSize: 13,
                            color: selected
                                ? Colors.white70
                                : Theme.of(context).hintColor,
                          ),
                        ),
                        if (selected) ...<Widget>[
                          const SizedBox(width: 8),
                          const Icon(Icons.check_rounded,
                              color: Colors.white, size: 18),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _reset() async {
    await showInterstitialAd();
    if (!mounted) return;
    resetPage(context, const SavingsCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Savings Calculator',
      icon: Icons.savings_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _FrequencyRow(
                name: _intervalName,
                onTap: _pickFrequency,
                palette: _palette,
              ),
              BuildTextField(
                title: 'Initial Deposit',
                hint: '0.00',
                isEnabled: true,
                textController: _principalController,
                palette: _palette,
                onPressedAction: null,
                widget: const Text(r'$'),
              ),
              BuildTextField(
                title: 'Regular Contribution',
                hint: '0.00',
                isEnabled: true,
                textController: _contributionController,
                palette: _palette,
                onPressedAction: null,
                widget: Text('/$_intervalName'),
              ),
              BuildTextField(
                title: 'Annual Interest Rate',
                hint: '0.00',
                isEnabled: true,
                textController: _rateController,
                palette: _palette,
                onPressedAction: null,
                widget: const Text('%'),
              ),
              BuildTextField(
                title: 'Time Period',
                hint: '0',
                isEnabled: true,
                textController: _yearsController,
                palette: _palette,
                onPressedAction: null,
                widget: const Text('yrs'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        BuildResultCard(
          title: 'Projected Balance',
          numeric: _balance,
          prefix: r'$',
          palette: _palette,
          group: false,
          icon: Icons.account_balance_wallet_rounded,
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'You Contribute',
              numeric: _contributed,
              prefix: r'$',
              palette: _palette,
              icon: Icons.payments_rounded,
            ),
            BuildResultCard(
              title: 'Interest Earned',
              numeric: _interest,
              prefix: r'$',
              palette: _palette,
              icon: Icons.trending_up_rounded,
            ),
          ],
        ),
        if (_hasInput)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              'Compounded daily at ${NumX.percentText(double.tryParse(_rateController.text) ?? 0, decimals: 2)} '
              'over ${int.tryParse(_yearsController.text) ?? 0} years, '
              'with ${savingsContributionCount(years: int.tryParse(_yearsController.text) ?? 0, contributionIntervalDays: _intervalDays)} contributions.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

class _FrequencyRow extends StatelessWidget {
  const _FrequencyRow({
    required this.name,
    required this.onTap,
    required this.palette,
  });

  final String name;
  final VoidCallback onTap;
  final ToolPalette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Frequency',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
          const SizedBox(height: 6),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onTap,
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: palette.linear,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Icon(Icons.expand_more_rounded,
                          size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
