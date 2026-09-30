import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

import '../../components/build_result_card.dart';
import '../../components/calculator_scaffold.dart';
import '../../services/history_service.dart';
import '../../utils/calculator_math.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import 'components/build_date_picker_field.dart';
import '../../utils/app_color.dart';
import '../../components/app_surface.dart';

class DateCalcPage extends StatefulWidget {
  const DateCalcPage({super.key});

  @override
  State<DateCalcPage> createState() => _DateCalcPageState();
}

class _DateCalcPageState extends State<DateCalcPage> {
  late DateTime _from;
  late DateTime _to;

  int _years = 0;
  int _months = 0;
  int _days = 0;
  int _totalDays = 0;

  static final DateFormat _format = DateFormat('dd MMM yyyy');
  static const ToolPalette _palette = AppPalettes.date;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _from = DateTime(now.year, now.month, now.day);
    _to = _from.add(const Duration(days: 30));
    _recalculate();
  }

  void _recalculate() {
    final ({int days, int months, int totalDays, int years}) result =
        dateBreakdown(from: _from, to: _to);
    setState(() {
      _years = result.years;
      _months = result.months;
      _days = result.days;
      _totalDays = result.totalDays;
    });
  }

  void _swap() {
    setState(() {
      final DateTime tmp = _from;
      _from = _to;
      _to = tmp;
    });
    _recalculate();
    _maybeSave();
  }

  void _onFromPicked(DateTime value) {
    setState(() => _from = value);
    _recalculate();
    _maybeSave();
  }

  void _onToPicked(DateTime value) {
    setState(() => _to = value);
    _recalculate();
    _maybeSave();
  }

  String? _lastSaved;
  void _maybeSave() {
    final String signature =
        '${_from.toIso8601String()}|${_to.toIso8601String()}';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Date',
        toolRoute: dateCalcPage,
        summary: '${_format.format(_from)} -> ${_format.format(_to)} = '
            '$_years y $_months m $_days d ($_totalDays days)',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _pickDate({
    required String title,
    required DateTime initial,
    required ValueChanged<DateTime> onPicked,
  }) {
    DateTime selected = initial;
    return showAppBottomSheet<void>(
      context: context,
      title: title,
      maxChildSize: 0.62,
      builder: (BuildContext sheetContext, ScrollController _) => Column(
        children: <Widget>[
          Expanded(
            child: DatePickerWidget(
              looping: true,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              initialDate: initial,
              locale: DateTimePickerLocale.en_us,
              dateFormat: 'dd-MMMM-yyyy',
              onChange: (DateTime newDate, _) => selected = newDate,
              pickerTheme: DateTimePickerTheme(
                backgroundColor: Theme.of(sheetContext).colorScheme.surface,
                itemTextStyle: TextStyle(
                  fontSize: 15,
                  color: Theme.of(sheetContext).colorScheme.onSurface,
                ),
                itemHeight: 70,
                dividerColor: Colors.transparent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
            child: AppButton(
              label: 'Select',
              icon: Icons.check_rounded,
              palette: _palette,
              onPressed: () {
                Navigator.of(sheetContext).pop();
                onPicked(selected);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _reset() {
    resetPage(context, const DateCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Date Calculator',
      icon: Icons.event_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppInputCard(
          children: <Widget>[
            BuildDatePickerField(
              title: 'From',
              value: _from,
              format: _format,
              palette: _palette,
              onTap: () => _pickDate(
                title: 'From Date',
                initial: _from,
                onPicked: _onFromPicked,
              ),
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: AppRadii.allLg,
                  onTap: _swap,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _palette.accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _palette.accent,
                        width: AppBorders.hairline,
                      ),
                    ),
                    child: const Icon(Icons.swap_vert_rounded,
                        color: Colors.white, size: 22),
                  ),
                ),
              ),
            ),
            BuildDatePickerField(
              title: 'To',
              value: _to,
              format: _format,
              palette: _palette,
              onTap: () => _pickDate(
                title: 'To Date',
                initial: _to,
                onPicked: _onToPicked,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'Years',
              value: '$_years',
              palette: _palette,
              icon: Icons.calendar_today_rounded,
            ),
            BuildResultCard(
              title: 'Months',
              value: '$_months',
              palette: _palette,
              icon: Icons.date_range_rounded,
            ),
            BuildResultCard(
              title: 'Days',
              value: '$_days',
              palette: _palette,
              icon: Icons.hourglass_bottom_rounded,
            ),
          ],
        ),
        const SizedBox(height: 6),
        AppAccentCard(
          palette: _palette,
          child: Row(
            children: <Widget>[
              const Icon(Icons.timelapse_rounded,
                  color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$_totalDays days in total',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
          child: Text(
            'Calendar-aware: 1 Mar to 1 Mar next year is exactly 1 year, '
            'not 365 days.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
