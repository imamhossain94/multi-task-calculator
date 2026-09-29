import 'package:flutter/material.dart';
import '../../services/google_ad_service.dart';

import '../../components/app_surface.dart';
import '../../components/calculator_scaffold.dart';
import '../../services/currency_api.dart';
import '../../utils/app_color.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import '../../utils/num_x.dart';
import 'model/exchange_rate_api.dart';
import 'model/exchange_rate_api_response.dart';

class CurrencyCalcPage extends StatefulWidget {
  const CurrencyCalcPage({super.key});

  @override
  State<CurrencyCalcPage> createState() => _CurrencyCalcPageState();
}

class _CurrencyCalcPageState extends State<CurrencyCalcPage> {
  final TextEditingController _fromController = TextEditingController(text: '1');
  final TextEditingController _toController = TextEditingController(text: '1');
  final TextEditingController _searchController = TextEditingController();

  /// Default currencies are looked up by code. The previous version used
  /// `currencyCodeList.entries.elementAt(142)`, which silently picked whatever
  /// happened to sit at that index.
  String _fromCode = CurrencyApiServices.defaultBaseCurrency;
  String _toCode = 'EUR';

  /// Base currency -> converted value, i.e. `1 <base> = rate <code>`.
  Map<String, double> _rateCache = <String, double>{};

  List<CurrencyRates> _rates = const <CurrencyRates>[];
  bool _isLoading = true;
  String? _error;
  DateTime? _updatedAt;

  static const ToolPalette _palette = AppPalettes.currency;

  @override
  void initState() {
    super.initState();
    _fromController.addListener(_onAmountChanged);
    _searchController.addListener(_onSearchChanged);
    _load();
  }

  @override
  void dispose() {
    _fromController
      ..removeListener(_onAmountChanged)
      ..dispose();
    _toController.dispose();
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_fromController.text) ?? 1;

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final ExchangeRateApiResponse response =
        await CurrencyApiServices().getExchangeRate(_fromCode);

    if (!mounted) return;

    if (response.isError) {
      setState(() {
        _isLoading = false;
        _error = response.error;
        _rates = const <CurrencyRates>[];
      });
      return;
    }

    final ExchangeRateApi api = response.exchangeRateApi;
    setState(() {
      _isLoading = false;
      _rateCache = Map<String, double>.of(api.conversionRates.rates);
      _rates = _buildRates(_searchController.text);
      _updatedAt = DateTime.now();
    });
    _syncTarget();
  }

  /// Recomputes every row from the cached rate table â€” no refetch needed.
  void _onAmountChanged() {
    setState(() => _rates = _buildRates(_searchController.text));
    _syncTarget();
  }

  void _onSearchChanged() {
    setState(() => _rates = _buildRates(_searchController.text));
  }

  /// Builds the display list, filtered by [query] and scaled by [amount].
  List<CurrencyRates> _buildRates(String query) {
    final String q = query.trim().toLowerCase();
    final double amount = _amount;
    return _rateCache.entries
        .where((MapEntry<String, double> e) =>
            q.isEmpty ||
            e.key.toLowerCase().contains(q) ||
            (currencyCodeList[e.key] ?? '').toLowerCase().contains(q))
        .map((MapEntry<String, double> e) => CurrencyRates(
              code: e.key,
              definition: currencyCodeList[e.key] ?? e.key,
              rates: (e.value * amount).toString(),
            ))
        .toList(growable: false)
      // `_rateCache` preserves insertion order; sorting keeps the list stable.
      ..sort((CurrencyRates a, CurrencyRates b) =>
          (a.code ?? '').compareTo(b.code ?? ''));
  }

  void _syncTarget() {
    final double? rate = _rateCache[_toCode.toUpperCase()];
    if (rate == null) {
      _toController.text = '0.00';
      return;
    }
    // The API returns rates relative to the base currency: 1 base = rate units.
    _toController.text = (_amount * rate).toStringAsFixed(4);
  }

  Future<void> _pickCurrency({required bool isFrom}) async {
    final String? picked = await showAppBottomSheet<String>(
      context: context,
      title: isFrom ? 'From Currency' : 'To Currency',
      maxChildSize: 0.9,
      builder: (BuildContext sheetContext, ScrollController controller) {
        final List<MapEntry<String, String>> codes =
            currencyCodeList.entries.toList();
        return ListView.builder(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          itemCount: codes.length,
          itemBuilder: (BuildContext _, int index) {
            final String code = codes[index].key;
            final String name = codes[index].value;
            final bool selected =
                isFrom ? code == _fromCode : code == _toCode;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.of(sheetContext).pop(code),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: selected ? _palette.linear : null,
                      color: selected
                          ? null
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          code,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: selected
                                ? Colors.white
                                : Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: selected
                                  ? Colors.white70
                                  : Theme.of(context).hintColor,
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
    if (isFrom) {
      if (picked == _fromCode) return;
      setState(() => _fromCode = picked);
      await _load();
    } else {
      setState(() => _toCode = picked);
      _syncTarget();
    }
  }

  /// Swaps the two currencies and refetches rates for the new base.
  Future<void> _swap() async {
    if (_fromCode == _toCode) return;
    setState(() {
      final String tmp = _fromCode;
      _fromCode = _toCode;
      _toCode = tmp;
    });
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Currency Converter',
      icon: Icons.currency_exchange_rounded,
      actions: <Widget>[
        IconButton(
          tooltip: 'Swap currencies',
          onPressed: _isLoading ? null : _swap,
          icon: const Icon(Icons.swap_horiz_rounded, size: 22),
        ),
        CalculatorResetButton(onPressed: _reload),
      ],
      children: <Widget>[
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _CurrencyField(
                title: 'From',
                code: _fromCode,
                controller: _fromController,
                editable: true,
                palette: _palette,
                onTapCode: () => _pickCurrency(isFrom: true),
              ),
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _swap,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: _palette.linear,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: _palette.accent.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.swap_vert_rounded,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ),
              _CurrencyField(
                title: 'To',
                code: _toCode,
                controller: _toController,
                editable: false,
                palette: _palette,
                onTapCode: () => _pickCurrency(isFrom: false),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _SearchField(
          controller: _searchController,
          palette: _palette,
          onClear: () => _searchController.clear(),
        ),
        const SizedBox(height: 8),
        _RateList(
          rates: _rates,
          isLoading: _isLoading,
          error: _error,
          palette: _palette,
          selectedCode: _toCode,
          updatedAt: _updatedAt,
          onRetry: _load,
        ),
      ],
    );
  }

  Future<void> _reload() async {
    await showInterstitialAd();
    if (!mounted) return;
    await _load();
  }
}

class _CurrencyField extends StatelessWidget {
  const _CurrencyField({
    required this.title,
    required this.code,
    required this.controller,
    required this.editable,
    required this.palette,
    required this.onTapCode,
  });

  final String title;
  final String code;
  final TextEditingController controller;
  final bool editable;
  final ToolPalette palette;
  final VoidCallback onTapCode;

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
              _CodeChip(code: code, palette: palette, onTap: onTapCode),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: controller,
                    enabled: editable,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                    decoration: const InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 14),
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

class _CodeChip extends StatelessWidget {
  const _CodeChip({
    required this.code,
    required this.palette,
    required this.onTap,
  });

  final String code;
  final ToolPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            gradient: palette.linear,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                code,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.expand_more_rounded,
                  color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.palette,
    required this.onClear,
  });

  final TextEditingController controller;
  final ToolPalette palette;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        decoration: InputDecoration(
          hintText: 'Search currency code or name',
          prefixIcon: Icon(Icons.search_rounded,
              color: palette.accent, size: 21),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (BuildContext _, TextEditingValue value, Widget? child) =>
                value.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.close_rounded, size: 19),
                        onPressed: onClear,
                      ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
        ),
      ),
    );
  }
}

class _RateList extends StatelessWidget {
  const _RateList({
    required this.rates,
    required this.isLoading,
    required this.error,
    required this.palette,
    required this.selectedCode,
    required this.updatedAt,
    required this.onRetry,
  });

  final List<CurrencyRates> rates;
  final bool isLoading;
  final String? error;
  final ToolPalette palette;
  final String selectedCode;
  final DateTime? updatedAt;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.cloud_off_rounded, size: 40, color: AppColors.danger),
            const SizedBox(height: 10),
            Text(
              error!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            AppButton(
              label: 'Retry',
              icon: Icons.refresh_rounded,
              palette: palette,
              onPressed: onRetry,
            ),
          ],
        ),
      );
    }

    if (rates.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            'No currencies match your search.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
    }

    final String stamp = updatedAt == null
        ? ''
        : '${updatedAt!.hour.toString().padLeft(2, '0')}:'
            '${updatedAt!.minute.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            stamp.isEmpty
                ? 'Exchange rates'
                : 'Exchange rates, updated at $stamp',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 6),
        ...rates.map((CurrencyRates rate) {
          final bool selected = rate.code == selectedCode;
          return Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: selected
                    ? palette.accent.withValues(alpha: 0.16)
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 48,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: palette.linear,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      rate.code ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      rate.definition ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                        color: selected
                            ? palette.accent
                            : Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    NumX.format(double.tryParse(rate.rates ?? '0'), decimals: 2),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}