import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import 'build_calc_button.dart';

/// Numeric / operator pad for the general calculator.
class BuildCalcPad extends StatelessWidget {
  const BuildCalcPad({super.key, required this.onPressed});

  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Table(
        children: <TableRow>[
          _row(<String>['â‹¯', '(', ')', 'âŒ«']),
          _row(<String>['C', '%', 'xâ¿', 'Ã·']),
          _row(<String>['7', '8', '9', 'Ã—']),
          _row(<String>['4', '5', '6', 'â€“']),
          _row(<String>['1', '2', '3', '+']),
          _row(<String>['0', '00', '.', '=']),
        ],
      ),
    );
  }

  TableRow _row(List<String> keys) => TableRow(
        children: keys
            .map(
              (String key) => BuildCalcButton(
                title: key,
                buttonColor: key == '=' ? AppPalettes.general.gradient.last : null,
                textColor: key == '=' ? Colors.white : null,
                onPressed: () => onPressed(key),
              ),
            )
            .toList(growable: false),
      );
}
