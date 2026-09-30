import 'package:flutter/material.dart';

import '../../components/build_result_card.dart';
import '../../components/calculator_scaffold.dart';
import '../../services/history_service.dart';
import '../../utils/calculator_math.dart';
import '../../utils/constant.dart';
import '../../utils/extensions.dart';
import '../../utils/num_x.dart';
import '../../utils/app_color.dart';
import '../../components/app_surface.dart';
import '../../utils/themes_mode.dart';

/// Compare products by their true unit price.
class UnitPriceCalcPage extends StatefulWidget {
  const UnitPriceCalcPage({super.key});

  @override
  State<UnitPriceCalcPage> createState() => _UnitPriceCalcPageState();
}

class _UnitPriceCalcPageState extends State<UnitPriceCalcPage> {
  static const int _initialRows = 8;
  static const int _maxRows = 30;

  final List<_PriceItem> _items = <_PriceItem>[];

  double _totalSpend = 0;
  double _totalQuantity = 0;
  double _cheapestUnitPrice = 0;
  double _mostExpensiveUnitPrice = 0;

  static const ToolPalette _palette = AppPalettes.unitPrice;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _initialRows; i++) {
      _items.add(_PriceItem()..addListener(_recalculate));
    }
    _recalculate();
  }

  @override
  void dispose() {
    for (final _PriceItem item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _recalculate() {
    double spend = 0;
    double quantity = 0;
    double cheapest = 0;
    double priciest = 0;
    bool any = false;

    for (final _PriceItem item in _items) {
      final double price = item.price;
      final double qty = item.quantity;
      // A zero quantity used to divide by zero and print `Infinity`.
      if (price <= 0 || qty <= 0) continue;

      any = true;
      spend += price;
      quantity += qty;

      final double unit = unitPrice(totalPrice: price, quantity: qty);
      if (cheapest == 0 || unit < cheapest) cheapest = unit;
      if (priciest == 0 || unit > priciest) priciest = unit;
    }

    if (!mounted) return;
    setState(() {
      _totalSpend = any ? spend : 0;
      _totalQuantity = any ? quantity : 0;
      _cheapestUnitPrice = cheapest;
      _mostExpensiveUnitPrice = priciest;
    });
  }

  void _addRow() {
    if (_items.length >= _maxRows) return;
    setState(() => _items.add(_PriceItem()..addListener(_recalculate)));
  }

  void _removeRow(int index) {
    if (_items.length <= 1) return;
    final _PriceItem removed = _items.removeAt(index);
    removed
      ..removeListener(_recalculate)
      ..dispose();
    setState(_recalculate);
  }

  void _reset() {
    resetPage(context, const UnitPriceCalcPage());
  }

  Future<void> _saveSummary() async {
    if (_totalSpend <= 0) return;
    await HistoryService.add(
      CalculationRecord(
        id: HistoryService.newId(),
        tool: 'Unit Price',
        toolRoute: unitPriceCalcPage,
        summary: '${NumX.money(_totalSpend)} over '
            '${NumX.format(_totalQuantity, decimals: 2)} items = '
            '${NumX.money(NumX.divide(_totalSpend, _totalQuantity))} average',
        createdAt: DateTime.now(),
      ),
    );
    if (mounted) showMessage(context, null, 'Summary saved to history');
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Unit Price',
      icon: Icons.balance_rounded,
      actions: <Widget>[CalculatorResetButton(onPressed: _reset)],
      children: <Widget>[
        BuildResultCard(
          title: 'Total Spend',
          numeric: _totalSpend,
          prefix: r'$',
          palette: _palette,
          group: false,
          icon: Icons.shopping_cart_rounded,
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            BuildResultCard(
              title: 'Total Quantity',
              numeric: _totalQuantity,
              decimals: 2,
              palette: _palette,
              icon: Icons.numbers_rounded,
            ),
            BuildResultCard(
              title: 'Average Unit Price',
              numeric: NumX.divide(_totalSpend, _totalQuantity),
              prefix: r'$',
              palette: _palette,
              icon: Icons.calculate_rounded,
            ),
          ],
        ),
        if (_cheapestUnitPrice > 0) ...<Widget>[
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              BuildResultCard(
                title: 'Cheapest Unit',
                numeric: _cheapestUnitPrice,
                prefix: r'$',
                palette: AppPalettes.salesTax,
                icon: Icons.thumb_up_rounded,
              ),
              BuildResultCard(
                title: 'Priciest Unit',
                numeric: _mostExpensiveUnitPrice,
                prefix: r'$',
                palette: AppPalettes.discount,
                icon: Icons.thumb_down_rounded,
              ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const _PriceHeaderRow(),
              const SizedBox(height: 6),
              ...List<Widget>.generate(_items.length, (int index) {
                return Padding(
                  key: ValueKey<String>(_items[index].id),
                  padding: const EdgeInsets.only(bottom: 6),
                  child: _PriceRow(
                    item: _items[index],
                    palette: _palette,
                    canRemove: _items.length > 1,
                    onRemove: () => _removeRow(index),
                  ),
                );
              }),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  Expanded(
                    child: AppButton(
                      label: 'Add item',
                      icon: Icons.add_rounded,
                      palette: _palette,
                      onPressed: _items.length >= _maxRows ? null : _addRow,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: AppButton(
                      label: 'Save summary',
                      icon: Icons.bookmark_add_rounded,
                      palette: AppPalettes.history,
                      onPressed: _totalSpend > 0 ? _saveSummary : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
          child: Text(
            'Add each product you are comparing. Rows with a price but no '
            'quantity are ignored, so the unit price is never `Infinity`.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

/// One editable line: total price, quantity, derived unit price.
class _PriceItem {
  _PriceItem() : id = UniqueKey().toString();

  final String id;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController =
      TextEditingController(text: '1');

  double get price => double.tryParse(priceController.text) ?? 0;
  double get quantity => double.tryParse(quantityController.text) ?? 0;

  void addListener(VoidCallback listener) {
    priceController.addListener(listener);
    quantityController.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    priceController.removeListener(listener);
    quantityController.removeListener(listener);
  }

  void dispose() {
    priceController.dispose();
    quantityController.dispose();
  }
}

class _PriceHeaderRow extends StatelessWidget {
  const _PriceHeaderRow();

  @override
  Widget build(BuildContext context) {
    Widget header(String label) => Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
        );

    return Padding(
      // Leaves room for the remove button.
      padding: const EdgeInsets.only(right: 32),
      child: Row(
        children: <Widget>[
          header('TOTAL PRICE'),
          header('QUANTITY'),
          header('UNIT PRICE'),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.item,
    required this.palette,
    required this.canRemove,
    required this.onRemove,
  });

  final _PriceItem item;
  final ToolPalette palette;
  final bool canRemove;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final double unit = unitPrice(
      totalPrice: item.price,
      quantity: item.quantity,
    );

    return Row(
      children: <Widget>[
        Expanded(child: _Cell(controller: item.priceController, hint: '0.00')),
        const SizedBox(width: 6),
        Expanded(child: _Cell(controller: item.quantityController, hint: '0')),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: unit > 0 ? palette.accent : ThemesMode.subtleFill,
              borderRadius: AppRadii.allMd,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  NumX.money(unit),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color:
                        unit > 0 ? Colors.white : Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 34,
          height: 44,
          child: IconButton(
            onPressed: canRemove ? onRemove : null,
            tooltip: 'Remove item',
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.close_rounded, size: 18),
          ),
        ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: ThemesMode.subtleFill,
        borderRadius: AppRadii.allMd,
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        decoration: InputDecoration(
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 6),
          hintText: hint,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.next,
        autocorrect: false,
        enableSuggestions: false,
      ),
    );
  }
}
