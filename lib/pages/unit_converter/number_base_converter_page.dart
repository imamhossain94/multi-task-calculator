import 'package:flutter/material.dart';

import '../../components/calculator_scaffold.dart';
import '../../services/history_service.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import '../../utils/app_color.dart';
import '../../components/app_surface.dart';
import '../../utils/themes_mode.dart';

/// The four number bases the app supports.
enum NumberBase {
  decimal('Decimal', 'DEC', 10, Icons.pin_rounded),
  hexadecimal('Hexadecimal', 'HEX', 16, Icons.tag_rounded),
  octal('Octal', 'OCT', 8, Icons.compress_rounded),
  binary('Binary', 'BIN', 2, Icons.memory_rounded);

  const NumberBase(this.label, this.shortLabel, this.radix, this.icon);

  final String label;
  final String shortLabel;
  final int radix;
  final IconData icon;

  /// Parses [input] in this base. Returns `null` when [input] is not a valid
  /// number for this radix —” e.g. `8` is not valid binary, `G` is not valid
  /// hex.
  BigInt? parse(String input) {
    final String cleaned = input.trim().toUpperCase().replaceAll(' ', '');
    if (cleaned.isEmpty) return null;
    // Only allow the digits valid for this radix, plus a leading sign.
    final int signOffset =
        (cleaned.startsWith('-') || cleaned.startsWith('+')) ? 1 : 0;
    for (int i = signOffset; i < cleaned.length; i++) {
      final int digit = cleaned.codeUnitAt(i) - 0x30;
      final int alphaDigit = cleaned.codeUnitAt(i) - 0x41 + 10;
      final int value = digit <= 9 ? digit : alphaDigit;
      if (value < 0 || value >= radix) return null;
    }
    return BigInt.tryParse(
      cleaned[0] == '-' || cleaned[0] == '+' ? cleaned.substring(1) : cleaned,
      radix: radix,
    );
  }

  /// Renders [value] in this base.
  String format(BigInt value) {
    final BigInt magnitude = value.abs();
    final String digits = magnitude.toRadixString(radix).toUpperCase();
    if (value.isNegative) return '-$digits';
    // Group binary/hex digits for readability.
    if (radix == 2) {
      return digits.replaceAllMapped(
        RegExp(r'(.{4})(?=.)'),
        (Match m) => '${m.group(1)} ',
      );
    }
    return digits;
  }
}

class NumberBaseConverterPage extends StatefulWidget {
  const NumberBaseConverterPage({super.key});

  @override
  State<NumberBaseConverterPage> createState() =>
      _NumberBaseConverterPageState();
}

class _NumberBaseConverterPageState extends State<NumberBaseConverterPage> {
  final TextEditingController _inputController =
      TextEditingController(text: '0');

  NumberBase _fromBase = NumberBase.decimal;
  NumberBase _toBase = NumberBase.binary;

  BigInt? _value;
  String? _error;

  static const ToolPalette _palette = AppPalettes.numberBase;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convert);
    _convert();
  }

  @override
  void dispose() {
    _inputController
      ..removeListener(_convert)
      ..dispose();
    super.dispose();
  }

  Future<void> _convert() async {
    final String raw = _inputController.text;
    if (raw.trim().isEmpty) {
      setState(() {
        _value = null;
        _error = null;
      });
      return;
    }

    final BigInt? parsed = _fromBase.parse(raw);
    if (parsed == null) {
      setState(() {
        _value = null;
        _error = raw.contains('.')
            ? 'Decimals are not supported. Use a whole number.'
            : 'Not a valid ${_fromBase.label.toLowerCase()} number';
      });
      return;
    }

    setState(() {
      _value = parsed;
      _error = null;
    });
    await _maybeSave(raw, parsed);
  }

  String? _lastSaved;
  Future<void> _maybeSave(String raw, BigInt value) async {
    // Skip the seeded "0": the field starts as 0 and saving that produces a
    // meaningless duplicate entry in the history list.
    if (value == BigInt.zero) return;
    final String signature = '${_fromBase.name}|$raw';
    if (_lastSaved == signature) return;
    _lastSaved = signature;
    await HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Number Base',
        toolRoute: numberBaseConverterPage,
        summary: '$raw (${_fromBase.shortLabel}) = '
            '${NumberBase.hexadecimal.format(value)} (HEX) = '
            '${NumberBase.octal.format(value)} (OCT) = '
            '${NumberBase.binary.format(value)} (BIN)',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _pickBase({required bool isFrom}) async {
    final NumberBase? picked = await showAppBottomSheet<NumberBase>(
      context: context,
      title: isFrom ? 'From base' : 'To base',
      maxChildSize: 0.6,
      builder: (BuildContext sheetContext, ScrollController _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: NumberBase.values.map((NumberBase base) {
          final bool selected = isFrom ? base == _fromBase : base == _toBase;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: AppRadii.allMd,
                onTap: () => Navigator.of(sheetContext).pop(base),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: selected ? _palette.accent : ThemesMode.subtleFill,
                    borderRadius: AppRadii.allMd,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(base.icon,
                          size: 20,
                          color: selected
                              ? Colors.white
                              : Theme.of(context).hintColor),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        base.label,
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
                        'base ${base.radix}',
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
        }).toList(growable: false),
      ),
    );

    if (picked == null || !mounted) return;
    setState(() {
      if (isFrom) {
        _fromBase = picked;
      } else {
        _toBase = picked;
      }
    });
    _convert();
  }

  void _swapBases() {
    setState(() {
      final NumberBase tmp = _fromBase;
      _fromBase = _toBase;
      _toBase = tmp;
    });
  }

  void _reset() {
    resetPage(context, const NumberBaseConverterPage());
  }

  @override
  Widget build(BuildContext context) {
    final BigInt? value = _value;

    return CalculatorScaffold(
      palette: _palette,
      title: 'Number Base',
      icon: Icons.tag_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        AppInputCard(
          children: <Widget>[
            _BaseField(
              title: 'From',
              base: _fromBase,
              controller: _inputController,
              palette: _palette,
              onTapBase: () => _pickBase(isFrom: true),
            ),
            AppSwapDivider(
              palette: _palette,
              onTap: _swapBases,
              tooltip: 'Swap bases',
            ),
            _BaseField(
              title: 'To',
              base: _toBase,
              // Read-only: pass the formatted string rather than a controller
              // so we don't allocate (and leak) one on every build.
              text: value == null ? '' : _toBase.format(value),
              palette: _palette,
              onTapBase: () => _pickBase(isFrom: false),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_error != null)
          AppCard(
            child: Row(
              children: <Widget>[
                const Icon(Icons.error_outline_rounded,
                    color: AppColors.danger, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _error!,
                    style: const TextStyle(
                        color: AppColors.danger, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          )
        else if (value != null)
          ...NumberBase.values
              .where((NumberBase b) => b != _toBase)
              .map((NumberBase base) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _ResultRow(
                      base: base,
                      text: base.format(value),
                      palette: _palette,
                    ),
                  )),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
          child: Text(
            'Type a number in the "from" base. Invalid digits are rejected, '
            'so 8 in binary or G in hexadecimal will not be accepted.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _BaseField extends StatelessWidget {
  const _BaseField({
    required this.title,
    required this.base,
    required this.palette,
    required this.onTapBase,
    this.controller,
    this.text,
  });

  final String title;
  final NumberBase base;
  final ToolPalette palette;
  final VoidCallback onTapBase;

  /// Set for the editable "from" field.
  final TextEditingController? controller;

  /// Set for the read-only "to" field.
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: AppRadii.allMd,
                  onTap: onTapBase,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: palette.accent,
                      borderRadius: AppRadii.allMd,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(base.icon, size: 17, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          base.shortLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.expand_more_rounded,
                            color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ThemesMode.subtleFill,
                    borderRadius: AppRadii.allMd,
                  ),
                  alignment: Alignment.centerLeft,
                  // A plain Text for the read-only side: no cursor, no
                  // selection handles, no leaked controller.
                  child: controller != null
                      ? TextField(
                          controller: controller,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            fontFamily: 'monospace',
                          ),
                          decoration: const InputDecoration(
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            hintText: '0',
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autocorrect: false,
                          enableSuggestions: false,
                        )
                      : Text(
                          text ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            fontFamily: 'monospace',
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.base,
    required this.text,
    required this.palette,
  });

  final NumberBase base;
  final String text;
  final ToolPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: ThemesMode.surface,
        borderRadius: AppRadii.allLg,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: palette.accent,
              borderRadius: AppRadii.allSm,
            ),
            child: Text(
              base.shortLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 11.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            base.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).hintColor,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
