import 'package:flutter/material.dart';

import '../../components/calculator_scaffold.dart';
import '../../utils/constant.dart';
import 'models/unit_category.dart';
import '../../utils/themes_mode.dart';
import '../../components/app_surface.dart';
import '../../utils/app_color.dart';

/// Category picker for the unit converter.
class UnitConverterPage extends StatelessWidget {
  const UnitConverterPage({super.key});

  static const ToolPalette _palette = AppPalettes.unitConverter;

  @override
  Widget build(BuildContext context) {
    return CalculatorScaffold(
      palette: _palette,
      title: 'Unit Converter',
      icon: Icons.swap_horiz_rounded,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Text(
            'Pick a category to convert between its units.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        _CategoryGrid(categories: unitCategories, palette: _palette),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Number Base Converter',
          icon: Icons.tag_rounded,
          palette: AppPalettes.numberBase,
          onPressed: () =>
              Navigator.of(context).pushNamed(numberBaseConverterPage),
        ),
      ],
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.categories, required this.palette});

  final List<UnitCategory> categories;
  final ToolPalette palette;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Three columns on a phone, more on a tablet.
        final int columns = constraints.maxWidth > 600 ? 5 : 3;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 0.98,
          children: categories.map((UnitCategory category) {
            return _CategoryTile(
              category: category,
              palette: palette,
              onTap: () => _open(context, category),
            );
          }).toList(growable: false),
        );
      },
    );
  }

  Future<void> _open(BuildContext context, UnitCategory category) async {
    if (!context.mounted) return;
    await Navigator.of(context).pushNamed(
      unitConverterChildPage,
      arguments: <String, String>{'category': category.label},
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.palette,
    required this.onTap,
  });

  final UnitCategory category;
  final ToolPalette palette;
  final VoidCallback onTap;

  /// Icon per category, so the grid is scannable at a glance.
  static IconData iconFor(String iconKey) {
    switch (iconKey) {
      case 'angle':
        return Icons.rotate_right_rounded;
      case 'area':
        return Icons.crop_square_rounded;
      case 'energy':
        return Icons.bolt_rounded;
      case 'force':
        return Icons.fitness_center_rounded;
      case 'length':
        return Icons.straighten_rounded;
      case 'power':
        return Icons.power_rounded;
      case 'pressure':
        return Icons.compress_rounded;
      case 'speed':
        return Icons.speed_rounded;
      case 'shoe':
        return Icons.ice_skating_rounded;
      case 'temperature':
        return Icons.thermostat_rounded;
      case 'storage':
        return Icons.storage_rounded;
      case 'weight':
        return Icons.monitor_weight_rounded;
      case 'time':
        return Icons.schedule_rounded;
      case 'volume':
        return Icons.local_drink_rounded;
      case 'fuel':
        return Icons.local_gas_station_rounded;
      case 'torque':
        return Icons.settings_rounded;
      default:
        return Icons.straighten_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.allLg,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: ThemesMode.surface,
            borderRadius: AppRadii.allLg,
            border: appBorder(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: palette.accent,
                  borderRadius: AppRadii.allMd,
                ),
                child: Icon(
                  iconFor(category.iconKey),
                  color: Colors.white,
                  size: 19,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Flexible(
                child: FittedBox(
                  // Long category names shrink rather than overflow the cell.
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        category.label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        '${category.units.length} units',
                        style: TextStyle(
                          fontSize: 10,
                          color: ThemesMode.onSurfaceMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
