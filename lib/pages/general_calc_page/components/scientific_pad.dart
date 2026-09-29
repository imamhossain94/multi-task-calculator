import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/screen_config.dart';
/// Collapsible row of scientific functions, toggled by the `â‹¯` key.
///
/// The `â‹¯` button previously called an empty `showMoreMenu()` stub, so the
/// function was advertised in the tooltip but did nothing.
class ScientificPad extends StatelessWidget {
  const ScientificPad({
    super.key,
    required this.onPressed,
    required this.palette,
    this.expanded = true,
    this.toggleKey,
  });

  final ValueChanged<String> onPressed;
  final ToolPalette palette;

  /// Whether the function grid is currently visible.
  final bool expanded;

  /// Emits `'â‹¯'` when the expand/collapse chip is tapped.
  final ValueChanged<String>? toggleKey;

  /// Label -> math function applied to the trailing operand.
  static const List<(String, String)> functions = <(String, String)>[
    ('sin', 'sin'),
    ('cos', 'cos'),
    ('tan', 'tan'),
    ('ln', 'ln'),
    ('log', 'log'),
    ('âˆš', 'âˆš'),
    ('xÂ²', 'xÂ²'),
    ('xÂ³', 'xÂ³'),
    ('1/x', '1/x'),
    ('x!', 'x!'),
    ('Â±', 'Â±'),
    ('Ï€', 'pi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Row(
            children: <Widget>[
              Text(
                'Scientific',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  color: Theme.of(context).hintColor,
                ),
              ),
              const Spacer(),
              if (toggleKey != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => toggleKey!('â‹¯'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: <Widget>[
                          Text(
                            expanded ? 'Hide' : 'Show',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Icon(
                            expanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 180),
          crossFadeState:
              expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 6),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 6,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1.7,
              children: functions.map(((String, String) entry) {
                final (String label, String fn) = entry;
                return _FunctionChip(
                  label: label,
                  color: palette.accent,
                  onTap: () => onPressed(fn),
                );
              }).toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}

class _FunctionChip extends StatelessWidget {
  const _FunctionChip({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(11),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: responsiveText(15),
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
