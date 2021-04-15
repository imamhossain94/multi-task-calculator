import 'package:flutter/material.dart';
import 'package:multi_task_calculator/pages/unit_price_calc/components/build_header_item.dart';
import 'package:multi_task_calculator/pages/unit_price_calc/components/build_row_text_editor.dart';
import 'package:multi_task_calculator/utils/screen_config.dart';
import 'package:multi_task_calculator/utils/themes_mode.dart';

class BuildUnitPriceRow extends StatefulWidget {
  const BuildUnitPriceRow({
    Key key,
  }) : super(key: key);

  @override
  _BuildUnitPriceRowState createState() => _BuildUnitPriceRowState();
}

class _BuildUnitPriceRowState extends State<BuildUnitPriceRow> {

  TextEditingController totalPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String totalPrice, quantity;
  double unitPrice;

  @override
  void initState() {
    quantity = '1';
    unitPrice = 0;

    quantityController.text = quantity;
    calculateUnitPrice();
    super.initState();
  }

  @override
  void dispose() {
    totalPriceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void calculateUnitPrice(){
    totalPriceController.addListener(() {
      updateResult();
    });

    quantityController.addListener(() {
      updateResult();
    });
  }

  void updateResult() {
    totalPrice = totalPriceController.value.text;
    quantity = quantityController.value.text;
    //Make null safety
    setState(() {
      double _totalPrice = double.tryParse(totalPrice)??0.0;
      int _quantity = int.tryParse(quantity) ?? 0;
      unitPrice = _totalPrice/_quantity;
    });

  }

  @override
  Widget build(BuildContext context) {

    ScreenConfig().init(context);
    ThemesMode().init(context);

    return Row(
      children: [
        BuildRowTextEditor(textController: totalPriceController),
        BuildRowTextEditor(textController: quantityController),
        BuildHeaderItem(title: unitPrice.toStringAsFixed(2)),
      ],
    );
  }
}
