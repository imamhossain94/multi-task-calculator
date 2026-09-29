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
/// The two directions the loan calculator can work in.
enum LoanMode {
  /// Given a loan amount, work out the monthly payment.
  monthlyCost('Monthly Cost'),

  /// Given a monthly budget, work out how much you can borrow.
  maximumLoan('Maximum Loan');

  const LoanMode(this.label);

  final String label;
}

class LoanCalcPage extends StatefulWidget {
  const LoanCalcPage({super.key});

  @override
  State<LoanCalcPage> createState() => _LoanCalcPageState();
}

class _LoanCalcPageState extends State<LoanCalcPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  /// Only used in [LoanMode.monthlyCost].
  final TextEditingController _monthlyController = TextEditingController();

  LoanMode _mode = LoanMode.monthlyCost;

  double _totalCost = 0;
  double _monthlyPayment = 0;
  double _totalInterest = 0;
  double _maxBorrow = 0;
  bool _hasInput = false;

  static const ToolPalette _palette = AppPalettes.loan;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_recalculate);
    _monthlyController.addListener(_recalculate);
    _rateController.addListener(_recalculate);
    _yearsController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _monthlyController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  bool get _isMonthlyCost => _mode == LoanMode.monthlyCost;

  void _recalculate() {
    final double rate = double.tryParse(_rateController.text) ?? 0;
    final int years = int.tryParse(_yearsController.text) ?? 0;

    if (rate < 0 || years <= 0) {
      if (_hasInput) _clearResults();
      return;
    }

    if (_isMonthlyCost) {
      final double amount = double.tryParse(_amountController.text) ?? 0;
      if (amount <= 0) {
        if (_hasInput) _clearResults();
        return;
      }

      final double monthly = loanMonthlyPayment(
        principal: amount,
        annualRatePercent: rate,
        years: years,
      );
      final double total = monthly * years * 12;
      setState(() {
        _hasInput = true;
        _monthlyPayment = monthly;
        _totalCost = total;
        _totalInterest = loanTotalInterest(
          principal: amount,
          annualRatePercent: rate,
          years: years,
        );
        _maxBorrow = 0;
      });
      _maybeSave(rate, years, 'amount=$amount');
    } else {
      final double monthly = double.tryParse(_monthlyController.text) ?? 0;
      if (monthly <= 0) {
        if (_hasInput) _clearResults();
        return;
      }

      final double borrow = loanMaxBorrow(
        monthlyPayment: monthly,
        annualRatePercent: rate,
        years: years,
      );
      final double total = monthly * years * 12;
      setState(() {
        _hasInput = true;
        _maxBorrow = borrow;
        _totalCost = total;
        _totalInterest = loanTotalInterest(
          principal: borrow,
          annualRatePercent: rate,
          years: years,
        );
        _monthlyPayment = monthly;
      });
      _maybeSave(rate, years, 'monthly=$monthly');
    }
  }

  void _clearResults() {
    setState(() {
      _hasInput = false;
      _totalCost = 0;
      _monthlyPayment = 0;
      _totalInterest = 0;
      _maxBorrow = 0;
    });
  }

  String? _lastSaved;
  void _maybeSave(double rate, int years, String extra) {
    final String signature = '${_mode.name}|$rate|$years|$extra|'
        '${_monthlyPayment.toStringAsFixed(2)}';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Loan',
        toolRoute: loanCalcPage,
        summary: _isMonthlyCost
            ? '${NumX.money(_totalCost - _totalInterest)} @ ${NumX.percentText(rate, decimals: 2)} '
                'for $years yrs = ${NumX.money(_monthlyPayment)}/mo'
            : '${NumX.money(_monthlyPayment)}/mo for $years yrs '
                '@ ${NumX.percentText(rate, decimals: 2)} = ${NumX.money(_maxBorrow)}',
        createdAt: DateTime.now(),
      ),
    );
  }

  void _onModeChanged(LoanMode mode) {
    if (mode == _mode) return;
    setState(() => _mode = mode);
    _recalculate();
  }

  Future<void> _reset() async {
    await showInterstitialAd();
    if (!mounted) return;
    resetPage(context, const LoanCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Loan Calculator',
      icon: Icons.account_balance_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppSegmented<LoanMode>(
                label: 'Mortgage Type',
                options: LoanMode.values,
                selected: _mode,
                palette: _palette,
                onChanged: _onModeChanged,
              ),
              const SizedBox(height: 8),
              if (_isMonthlyCost)
                BuildTextField(
                  title: 'Loan Amount',
                  hint: '0.00',
                  isEnabled: true,
                  textController: _amountController,
                  palette: _palette,
                  onPressedAction: null,
                  widget: const Text(r'$'),
                )
              else
                BuildTextField(
                  title: 'Monthly Payment',
                  hint: '0.00',
                  isEnabled: true,
                  textController: _monthlyController,
                  palette: _palette,
                  onPressedAction: null,
                  widget: const Text(r'$'),
                ),
              BuildTextField(
                title: 'Interest Rate',
                hint: '0.00',
                isEnabled: true,
                textController: _rateController,
                palette: _palette,
                onPressedAction: null,
                widget: const Text('%'),
              ),
              BuildTextField(
                title: 'Period',
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
        if (_isMonthlyCost) ...<Widget>[
          Row(
            children: <Widget>[
              BuildResultCard(
                title: 'Monthly Payment',
                numeric: _monthlyPayment,
                prefix: r'$',
                palette: _palette,
                icon: Icons.calendar_month_rounded,
              ),
              BuildResultCard(
                title: 'Total Cost',
                numeric: _totalCost,
                prefix: r'$',
                palette: _palette,
                icon: Icons.payments_rounded,
              ),
            ],
          ),
          if (_hasInput)
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Text(
                'Of which ${NumX.money(_totalInterest)} is interest.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ] else ...<Widget>[
          Row(
            children: <Widget>[
              BuildResultCard(
                title: 'You Could Borrow',
                numeric: _maxBorrow,
                prefix: r'$',
                palette: _palette,
                icon: Icons.trending_up_rounded,
              ),
              BuildResultCard(
                title: 'Total Repaid',
                numeric: _totalCost,
                prefix: r'$',
                palette: _palette,
                icon: Icons.payments_rounded,
              ),
            ],
          ),
          if (_hasInput)
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Text(
                'Of which ${NumX.money(_totalInterest)} is interest.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
        _SuggestionCard(),
      ],
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppGradientCard(
      palette: AppPalettes.loan,
      radius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.auto_awesome_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Need a full amortisation schedule?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Our Mortgage Calculator app generates a downloadable '
            'amortisation schedule PDF.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 13.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          AppButton(
            label: 'Download Mortgage Calculator',
            icon: Icons.download_rounded,
            palette: AppPalettes.general,
            onPressed: () => openExternal(context, loanAppLink),
          ),
        ],
      ),
    );
  }
}
