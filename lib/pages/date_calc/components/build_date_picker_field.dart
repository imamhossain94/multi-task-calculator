import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/themes_mode.dart';
import '../../../utils/app_color.dart';

/// Read-only date field that opens a picker when tapped.
///
/// The old page exposed a disabled `TextField` whose hint said
/// `dd/mm/yyyy` while the value was a raw `toString().substring(0, 10)`
/// (`2026-09-29`). This renders a proper formatted date instead.
class BuildDatePickerField extends StatelessWidget {
  const BuildDatePickerField({
    super.key,
    required this.title,
    required this.value,
    required this.format,
    required this.palette,
    required this.onTap,
  });

  final String title;
  final DateTime value;
  final DateFormat format;
  final ToolPalette palette;
  final VoidCallback onTap;

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
              color: ThemesMode.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: AppRadii.allMd,
              onTap: onTap,
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ThemesMode.subtleFill,
                  borderRadius: AppRadii.allMd,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.event_rounded, size: 19, color: palette.accent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        format.format(value),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(Icons.expand_more_rounded,
                        size: 22, color: palette.accent),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
