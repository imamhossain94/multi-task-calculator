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
import '../../utils/themes_mode.dart';

class HealthCalcPage extends StatefulWidget {
  const HealthCalcPage({super.key});

  @override
  State<HealthCalcPage> createState() => _HealthCalcPageState();
}

class _HealthCalcPageState extends State<HealthCalcPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _isMale = true;

  double _bmi = 0;
  double _bmr = 0;
  String _status = '';
  bool _hasBmi = false;
  bool _hasBmr = false;

  static const ToolPalette _palette = AppPalettes.health;

  @override
  void initState() {
    super.initState();
    _heightController.addListener(_recalculate);
    _weightController.addListener(_recalculate);
    _ageController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _recalculate() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final int age = int.tryParse(_ageController.text) ?? 0;

    // BMI only needs height and weight; BMR additionally needs an age.
    // Previously both were gated on `age`, so BMI silently stayed at 0 until
    // an age was typed in.
    final bool hasBmi = height > 0 && weight > 0;
    final double bmiValue =
        hasBmi ? bmi(heightCm: height, weightKg: weight) : 0;
    final String status = hasBmi ? bmiCategory(bmiValue) : '';

    final bool hasBmr = hasBmi && age > 0;
    final double bmrValue = hasBmr
        ? bmr(
            weightKg: weight,
            heightCm: height,
            age: age,
            isMale: _isMale,
          )
        : 0;

    if (hasBmi == _hasBmi &&
        hasBmr == _hasBmr &&
        bmiValue == _bmi &&
        bmrValue == _bmr &&
        status == _status) {
      return;
    }

    setState(() {
      _hasBmi = hasBmi;
      _hasBmr = hasBmr;
      _bmi = bmiValue;
      _bmr = bmrValue;
      _status = status;
    });

    if (hasBmi) _maybeSave(height, weight, age, bmiValue, bmrValue);
  }

  String? _lastSaved;
  void _maybeSave(
      double height, double weight, int age, double bmi, double bmr) {
    final String signature = '$height|$weight|$age|$_isMale';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Health',
        toolRoute: healthCalcPage,
        summary: '${NumX.format(height)} cm, ${NumX.format(weight)} kg'
            '${age > 0 ? ', $age yrs' : ''} '
            '-> BMI ${NumX.format(bmi)}'
            '${bmr > 0 ? ', BMR ${NumX.format(bmr)}' : ''}',
        createdAt: DateTime.now(),
      ),
    );
  }

  void _onGenderChanged(bool male) {
    setState(() => _isMale = male);
    _recalculate();
  }

  void _reset() {
    resetPage(context, const HealthCalcPage());
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Health Calculator',
      icon: Icons.favorite_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppInputCard(
          children: <Widget>[
            _genderField(context),
            _heightField(context),
            _weightField(context),
            _ageField(context),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'BMI',
              numeric: _bmi,
              palette: _palette,
              icon: Icons.monitor_weight_rounded,
            ),
            BuildResultCard(
              title: 'BMR',
              numeric: _bmr,
              suffix: _hasBmr ? ' kcal' : '',
              palette: _palette,
              icon: Icons.local_fire_department_rounded,
            ),
          ],
        ),
        if (_hasBmi) ...<Widget>[
          const SizedBox(height: AppSpacing.md),
          AppAccentCard(
            palette: _palette,
            child: Row(
              children: <Widget>[
                const Icon(Icons.info_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        _status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'BMI = weight (kg) / height² (m). '
                        'Add your age to see BMR.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        if (!_hasBmi)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Text(
              'Enter your height and weight to see your BMI.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }

  // ------------------------------------------------------------------ fields

  Widget _genderField(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: AppSpacing.xs + 2),
            child: Text(
              'GENDER',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: ThemesMode.onSurfaceMuted,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _GenderButton(
                  label: 'Male',
                  icon: Icons.male_rounded,
                  color: const Color(0xFF3B82F6),
                  selected: _isMale,
                  onTap: () => _onGenderChanged(true),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _GenderButton(
                  label: 'Female',
                  icon: Icons.female_rounded,
                  color: const Color(0xFFEC4899),
                  selected: !_isMale,
                  onTap: () => _onGenderChanged(false),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _heightField(BuildContext context) => BuildTextField(
        title: 'Height',
        hint: '0.00',
        isEnabled: true,
        textController: _heightController,
        palette: _palette,
        onPressedAction: null,
        widget: const Text('cm'),
      );

  Widget _weightField(BuildContext context) => BuildTextField(
        title: 'Weight',
        hint: '0.00',
        isEnabled: true,
        textController: _weightController,
        palette: _palette,
        onPressedAction: null,
        widget: const Text('kg'),
      );

  Widget _ageField(BuildContext context) => BuildTextField(
        title: 'Age',
        hint: '0',
        isEnabled: true,
        textController: _ageController,
        palette: _palette,
        onPressedAction: null,
        widget: const Text('yrs'),
      );
}

class _GenderButton extends StatelessWidget {
  const _GenderButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.allMd,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 46,
          decoration: BoxDecoration(
            color: selected ? color : ThemesMode.subtleFill,
            borderRadius: AppRadii.allMd,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,
                  size: 20,
                  color: selected ? Colors.white : Theme.of(context).hintColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: selected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
