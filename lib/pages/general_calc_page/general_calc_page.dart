import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

import '../../components/calculator_scaffold.dart';
import '../../utils/constant.dart';
import '../../services/history_service.dart';
import 'components/build_calc_pad.dart';
import 'components/build_display.dart';
import 'components/general_calc_body.dart';
import 'components/scientific_pad.dart';
import '../../utils/app_color.dart';

class GeneralCalcPage extends StatefulWidget {
  const GeneralCalcPage({super.key});

  @override
  State<GeneralCalcPage> createState() => _GeneralCalcPageState();
}

class _GeneralCalcPageState extends State<GeneralCalcPage> {
  /// What the user typed, using the display glyphs from [CalcGlyphs].
  String _expression = '';

  /// The live result while typing.
  String _preview = '';

  /// The committed result after pressing `=`.
  String _result = '';

  /// When true, the next digit starts a new calculation rather than
  /// appending to the committed result (standard calculator behaviour).
  bool _freshEntry = false;

  String? _error;
  bool _showScientific = true;

  static const ToolPalette _palette = AppPalettes.general;
  static const String _moreKey = CalcGlyphs.more;

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'General Calculator',
      icon: Icons.calculate_rounded,
      // Horizontal padding only: the general calculator manages its own
      // vertical rhythm so the three bands line up exactly.
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
      // The key pad needs a Flex parent - a SingleChildScrollView is not one.
      fillHeight: true,
      actions: <Widget>[
        IconButton(
          tooltip: 'History',
          onPressed: _openHistory,
          icon: const Icon(Icons.history_rounded, size: 21),
        ),
        CalculatorResetButton(onPressed: _clear),
      ],
      children: <Widget>[
        // `Expanded` so the body receives a bounded height: a Column passes
        // unbounded main-axis constraints to its non-flex children, which would
        // break the display's `Expanded` further down.
        Expanded(
          child: GeneralCalcBody(
            display: BuildDisplay(
              expression: _expression,
              preview: _result.isNotEmpty
                  ? _result
                  : (_preview.isEmpty ? '' : '= $_preview'),
              error: _error,
              palette: _palette,
            ),
            scientific: ScientificPad(
              onPressed: _onScientific,
              palette: _palette,
              expanded: _showScientific,
              toggleKey: _onKey,
            ),
            onKey: _onKey,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------ input

  void _onKey(String key) {
    // The "more" key toggles the scientific row rather than being a no-op.
    if (key == _moreKey) {
      setState(() => _showScientific = !_showScientific);
      return;
    }
    setState(() {
      _error = null;
      switch (key) {
        case 'C':
          _clearState();
        case 'del':
          _delete();
        case '=':
          _commit();
        default:
          _append(key);
      }
    });
  }

  void _onScientific(String function) {
    setState(() {
      _error = null;
      _result = '';
      _freshEntry = false;

      // Pi inserts a literal rather than transforming an operand.
      if (function == 'pi') {
        _expression = _replaceTrailingOperand('pi');
        _preview = _evaluate(_expression);
        return;
      }

      final double? operand = _trailingOperand();
      if (operand == null) {
        _error = 'Enter a number first';
        return;
      }
      final double applied = _apply(function, operand);
      if (applied.isNaN || !applied.isFinite) {
        _error = 'Undefined';
        return;
      }
      _expression = _replaceTrailingOperand(_compact(applied));
      _preview = _evaluate(_expression);
    });
  }

  /// Appends [key], keeping the expression syntactically valid.
  void _append(String key) {
    final bool isDigit = key == '00' || double.tryParse(key) != null;

    // After pressing `=`, a digit starts a fresh calculation while an
    // operator continues from the result. This is what every phone
    // calculator does.
    if (_freshEntry && isDigit) {
      _expression = key == '00' ? '0' : key;
      _result = '';
      _preview = _evaluate(_expression);
      _freshEntry = false;
      return;
    }
    _freshEntry = false;

    final String base = _expression;

    if (base.isEmpty) {
      // A leading operator would make the expression unparseable.
      if (_isOperator(key)) return;
      _expression = key == '00' ? '0' : key;
    } else {
      final String last = base[base.length - 1];

      // Never allow two operators in a row (e.g. `5++3`).
      if (_isOperator(key)) {
        if (_isOperator(last)) {
          _expression = base.substring(0, base.length - 1) + _toMath(key);
        } else {
          _expression = base + _toMath(key);
        }
        _preview = _evaluate(_expression);
        return;
      }

      // Only one decimal point per number.
      if (key == '.') {
        final int lastOperator = _lastOperatorIndex(base);
        final String currentNumber = base.substring(lastOperator + 1);
        if (currentNumber.contains('.')) return;
      }

      _expression = base + (key == '00' ? '00' : key);
    }
    _preview = _evaluate(_expression);
  }

  void _delete() {
    if (_expression.isEmpty) return;
    _result = '';
    _error = null;
    _freshEntry = false;
    if (_expression.length == 1) {
      _expression = '';
    } else {
      _expression = _expression.substring(0, _expression.length - 1);
    }
    _preview = _evaluate(_expression);
  }

  void _clearState() {
    _expression = '';
    _preview = '';
    _result = '';
    _error = null;
    _freshEntry = false;
  }

  void _clear() {
    _clearState();
    setState(() {});
  }

  /// Commits the current expression to the result line.
  void _commit() {
    final String value = _evaluate(_expression);
    if (value.isEmpty) {
      setState(() => _error = 'Incorrect math expression');
      return;
    }
    setState(() {
      _result = value;
      _preview = '';
      _freshEntry = true;
    });
    _maybeSave('$_expression = $value');
  }

  void _openHistory() async {
    if (!mounted) return;
    await Navigator.of(context).pushNamed<String>(historyPage);
  }

  String? _lastSaved;
  void _maybeSave(String summary) {
    if (_lastSaved == summary) return;
    _lastSaved = summary;
    HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'General',
        toolRoute: generalCalcPage,
        summary: summary,
        createdAt: DateTime.now(),
      ),
    );
  }

  // ------------------------------------------------------------------ maths

  /// Converts a display glyph to its math equivalent.
  /// Converts a display glyph to its math equivalent.
  static String _toMath(String symbol) {
    switch (symbol) {
      case CalcGlyphs.multiply:
        return '*';
      case CalcGlyphs.divide:
        return '/';
      case CalcGlyphs.minus:
      case '-':
        return '-';
      case CalcGlyphs.powerOf:
        return '^';
      case '%':
        return '%';
      default:
        return symbol;
    }
  }

  static bool _isOperator(String key) => <String>{
        '+',
        CalcGlyphs.multiply,
        CalcGlyphs.divide,
        CalcGlyphs.minus,
        CalcGlyphs.powerOf,
        '%',
        '(',
        ')',
      }.contains(key);

  /// Index of the last top-level operator, ignoring anything inside brackets.
  static int _lastOperatorIndex(String expression) {
    int depth = 0;
    for (int i = expression.length - 1; i >= 0; i--) {
      final String c = expression[i];
      if (c == ')') depth++;
      if (c == '(') depth--;
      if (depth == 0 &&
          const <String>{'+', '-', '*', '/', '^', '%'}.contains(c)) {
        return i;
      }
    }
    return -1;
  }

  /// The number the user is currently typing, if any.
  double? _trailingOperand() {
    final int op = _lastOperatorIndex(_expression);
    final String raw = _expression.substring(op + 1);
    if (raw.isEmpty) return null;
    return double.tryParse(raw);
  }

  String _replaceTrailingOperand(String replacement) {
    final int op = _lastOperatorIndex(_expression);
    return _expression.substring(0, op + 1) + replacement;
  }

  static double _apply(String function, double x) {
    switch (function) {
      case 'sin':
        return _sin(_rad(x));
      case 'cos':
        return _cosRadians(_rad(x));
      case 'tan':
        return _tanRadians(_rad(x));
      case 'ln':
        return x <= 0 ? double.nan : _log(x);
      case 'log':
        return x <= 0 ? double.nan : _log(x) / _log(10);
      case SciGlyphs.sqrt:
        return x < 0 ? double.nan : _sqrt(x);
      case SciGlyphs.squared:
        return x * x;
      case SciGlyphs.cubed:
        return x * x * x;
      case '1/x':
        return x == 0 ? double.nan : 1 / x;
      case 'x!':
        return _factorial(x);
      case SciGlyphs.plusMinus:
        return -x;
      default:
        return double.nan;
    }
  }

  static double _factorial(double x) {
    // Only non-negative integers up to 170 (beyond that it overflows a double).
    if (x < 0 || x > 170) return double.nan;
    if (x != x.roundToDouble()) return double.nan;
    if (x <= 1) return 1;
    var result = 1.0;
    for (int i = 2; i <= x.toInt(); i++) {
      result *= i;
    }
    return result;
  }

  /// Trig functions take degrees, which is what a phone calculator expects.
  static double _rad(double degrees) => degrees * 3.141592653589793 / 180;

  /// Taylor series for sin, adequate for the reduced range used here.
  static double _sin(double r) {
    final double x = r % (2 * 3.141592653589793);
    double sum = 0;
    double term = x;
    for (int i = 1; i <= 12; i++) {
      sum += term;
      term *= -1 * x * x / ((2 * i) * (2 * i + 1));
    }
    return sum;
  }

  static double _cosRadians(double r) {
    final double x = r % (2 * 3.141592653589793);
    double sum = 0;
    double term = 1;
    for (int i = 0; i < 12; i++) {
      sum += term;
      term *= -1 * x * x / ((2 * i + 1) * (2 * i + 2));
    }
    return sum;
  }

  static double _tanRadians(double r) {
    final double c = _cosRadians(r);
    if (c == 0) return double.nan;
    return _sin(r) / c;
  }

  static double _log(double x) {
    // Natural log via the standard atanh series.
    int exponent = 0;
    double value = x;
    while (value > 1.5) {
      value /= 2;
      exponent++;
    }
    while (value < 0.75) {
      value *= 2;
      exponent--;
    }
    final double z = (value - 1) / (value + 1);
    final double z2 = z * z;
    double sum = 0;
    double term = z;
    for (int i = 1; i <= 15; i += 2) {
      sum += term / i;
      term *= z2;
    }
    return 2 * sum + exponent * 0.6931471805599453;
  }

  static double _sqrt(double x) {
    if (x == 0) return 0;
    // Newton's method; converges quickly for the magnitudes involved.
    double guess = x > 1 ? x / 2 : 1;
    for (int i = 0; i < 40; i++) {
      guess = 0.5 * (guess + x / guess);
    }
    return guess;
  }

  /// Evaluates [_expression], returning an empty string when it is not yet a
  /// complete expression.
  String _evaluate(String expression) {
    if (expression.isEmpty) return '';
    if (_isOperator(expression[expression.length - 1])) return '';

    final String math = _toMathExpression(expression);
    try {
      final num value = math.interpret();
      if (!value.isFinite) return '';
      return _compact(value);
    } catch (_) {
      return '';
    }
  }

  /// Rewrites the display expression for `function_tree`.
  String _toMathExpression(String expression) {
    String out = expression;
    // `^` is what function_tree understands for exponentiation; `^` already works for function_tree.
    out = out
        .replaceAll(CalcGlyphs.multiply, '*')
        .replaceAll(CalcGlyphs.divide, '/')
        .replaceAll(CalcGlyphs.minus, '-');
    out = out.replaceAllMapped(
      RegExp(r'(\d|\))\s*\('),
      (Match m) => '${m.group(1)}*(',
    );
    // A trailing `%` is a percentage of the preceding number.
    out = out.replaceAll('%', '/100');
    return out;
  }

  /// Formats a number for display: no trailing `.0`, no float noise.
  static String _compact(num value) {
    if (!value.isFinite) return '';
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toInt().toString();
    }
    // Round away binary representation noise such as 0.1 + 0.2.
    final double rounded = (value * 1e12).roundToDouble() / 1e12;
    String text = rounded.toStringAsFixed(10);
    if (text.contains('.')) {
      text = text.replaceFirst(RegExp(r'0+$'), '');
      text = text.replaceFirst(RegExp(r'\.$'), '');
    }
    return text;
  }
}
