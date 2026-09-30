import 'package:flutter/material.dart';

import '../../components/calculator_scaffold.dart';
import '../../utils/extensions.dart';
import 'models/unit_category.dart';
import '../../utils/app_color.dart';
import '../../components/app_surface.dart';
import '../../utils/themes_mode.dart';

class UnitConverterChildPage extends StatefulWidget {
  const UnitConverterChildPage({super.key, this.arguments});

  /// `{'category': '<label>'}` —” see [UnitCategory.label].
  final Object? arguments;

  @override
  State<UnitConverterChildPage> createState() => _UnitConverterChildPageState();
}

class _UnitConverterChildPageState extends State<UnitConverterChildPage> {
  final TextEditingController _fromController =
      TextEditingController(text: '1');
  final TextEditingController _toController = TextEditingController();

  UnitCategory? _category;
  Object? _fromUnit;
  Object? _toUnit;

  List<_UnitRow> _rows = const <_UnitRow>[];
  bool _isLoading = true;
  String? _error;

  static const ToolPalette _palette = AppPalettes.unitConverter;

  @override
  void initState() {
    super.initState();
    _fromController.addListener(_convert);
    _resolveCategory();
  }

  @override
  void dispose() {
    _fromController
      ..removeListener(_convert)
      ..dispose();
    _toController.dispose();
    super.dispose();
  }

  UnitCategory? _categoryFromArguments() {
    if (widget.arguments is Map) {
      final Object? label = (widget.arguments as Map)['category'];
      if (label is String) return unitCategoryByLabel(label);
    }
    return null;
  }

  void _resolveCategory() {
    final UnitCategory? category = _categoryFromArguments();
    if (category == null) {
      setState(() {
        _isLoading = false;
        _error = 'That converter does not exist.';
      });
      return;
    }

    setState(() {
      _category = category;
      // Default to the first two units in the category.
      _fromUnit = category.units.values.first;
      _toUnit = category.units.values.length > 1
          ? category.units.values.elementAt(1)
          : _fromUnit;
      _isLoading = false;
    });
    _convert();
  }

  String _pretty(Object? unit) {
    final UnitCategory? category = _category;
    if (category == null || unit == null) return '';
    return category.pretty(unit);
  }

  /// Human label for a unit key, with underscores turned into spaces.
  String _labelFor(String key) => UnitCategory.labelFor(key);

  void _convert() {
    final UnitCategory? category = _category;
    if (category == null || _fromUnit == null) return;

    final double amount = double.tryParse(_fromController.text) ?? 0;

    setState(() => _isLoading = true);

    try {
      // A fresh converter each time: `units_converter` mutates its state.
      final dynamic converter = category.build();
      converter.convert(_fromUnit, amount);
      final List<dynamic> all = converter.getAll() as List<dynamic>;

      final List<_UnitRow> rows = all
          .map((dynamic unit) => _UnitRow(
                name: _pretty(unit.name),
                value: (unit.value as num).toDouble(),
              ))
          .toList(growable: false);

      // Sort alphabetically so the order does not depend on the package.
      rows.sort((_UnitRow a, _UnitRow b) => a.name.compareTo(b.name));

      final String target = _pretty(_toUnit);
      final _UnitRow? match =
          rows.where((_UnitRow r) => r.name == target).firstOrNull;

      setState(() {
        _rows = rows;
        _isLoading = false;
        _toController.text =
            match == null ? '0.00' : match.value.toStringAsFixed(4);
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Could not convert that value.';
        _rows = const <_UnitRow>[];
      });
    }
  }

  Future<void> _pickUnit({required bool isFrom}) async {
    final UnitCategory? category = _category;
    if (category == null) return;

    final List<MapEntry<String, Object?>> entries =
        category.units.entries.toList();

    final String? picked = await showAppBottomSheet<String>(
      context: context,
      title: isFrom ? 'From unit' : 'To unit',
      maxChildSize: 0.9,
      builder: (BuildContext sheetContext, ScrollController controller) {
        return ListView.builder(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          itemCount: entries.length,
          itemBuilder: (BuildContext _, int index) {
            final String label = entries[index].key;
            final bool selected = isFrom
                ? entries[index].value == _fromUnit
                : entries[index].value == _toUnit;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: AppRadii.allMd,
                  onTap: () => Navigator.of(sheetContext).pop(label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? _palette.accent
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: AppRadii.allMd,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _labelFor(label),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14.5,
                              color: selected
                                  ? Colors.white
                                  : Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.color,
                            ),
                          ),
                        ),
                        if (selected)
                          const Icon(Icons.check_rounded,
                              color: Colors.white, size: 18),
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

    if (picked == null || !mounted) return;
    final Object? unit = category.units[picked];
    setState(() {
      if (isFrom) {
        _fromUnit = unit;
      } else {
        _toUnit = unit;
      }
    });
    _convert();
  }

  void _swap() {
    if (_fromUnit == null || _toUnit == null) return;
    final double converted = double.tryParse(_toController.text) ?? 1;
    setState(() {
      final Object? tmp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = tmp;
      _fromController.text =
          converted == 0 ? '1' : converted.toStringAsFixed(4);
    });
    _convert();
  }

  Future<void> _reset() async {
    if (!mounted) return;
    resetPage(
      context,
      UnitConverterChildPage(
        arguments: <String, String>{'category': _category?.label ?? ''},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UnitCategory? category = _category;
    return CalculatorScaffold(
      palette: _palette,
      title: category?.label ?? 'Unit Converter',
      icon: Icons.swap_horiz_rounded,
      actions: category == null
          ? const <Widget>[]
          : <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        if (_error != null)
          AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.error_outline_rounded,
                    color: AppColors.danger, size: 36),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        else ...<Widget>[
          AppInputCard(
            children: <Widget>[
              _UnitField(
                title: 'From',
                unitName: _labelFor(_pretty(_fromUnit)),
                controller: _fromController,
                editable: true,
                palette: _palette,
                onTapUnit: () => _pickUnit(isFrom: true),
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
                      ),
                      child: const Icon(Icons.swap_vert_rounded,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ),
              _UnitField(
                title: 'To',
                unitName: _labelFor(_pretty(_toUnit)),
                controller: _toController,
                editable: false,
                palette: _palette,
                onTapUnit: () => _pickUnit(isFrom: false),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _UnitList(
            rows: _rows,
            isLoading: _isLoading,
            palette: _palette,
            selectedName: _pretty(_toUnit),
          ),
        ],
      ],
    );
  }
}

class _UnitRow {
  const _UnitRow({required this.name, required this.value});

  final String name;
  final double value;
}

class _UnitField extends StatelessWidget {
  const _UnitField({
    required this.title,
    required this.unitName,
    required this.controller,
    required this.editable,
    required this.palette,
    required this.onTapUnit,
  });

  final String title;
  final String unitName;
  final TextEditingController controller;
  final bool editable;
  final ToolPalette palette;
  final VoidCallback onTapUnit;

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
              Flexible(
                flex: 5,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: AppRadii.allMd,
                    onTap: onTapUnit,
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: palette.accent,
                        borderRadius: AppRadii.allMd,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              unitName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Icon(Icons.expand_more_rounded,
                              color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 4,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: ThemesMode.subtleFill,
                    borderRadius: AppRadii.allMd,
                  ),
                  child: TextField(
                    controller: controller,
                    enabled: editable,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      hintText: '0.00',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
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

class _UnitList extends StatelessWidget {
  const _UnitList({
    required this.rows,
    required this.isLoading,
    required this.palette,
    required this.selectedName,
  });

  final List<_UnitRow> rows;
  final bool isLoading;
  final ToolPalette palette;
  final String selectedName;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (rows.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('No results')),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows.map((_UnitRow row) {
        final bool selected = row.name == selectedName;
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: selected
                  ? palette.accent.withValues(alpha: 0.16)
                  : ThemesMode.surface,
              borderRadius: AppRadii.allLg,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    row.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                      color: selected
                          ? palette.accent
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  row.value.toStringAsFixed(4),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}
