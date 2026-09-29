import 'dart:convert';

import 'shared_pref_services.dart';

/// One saved calculation.
class CalculationRecord {
  const CalculationRecord({
    required this.id,
    required this.tool,
    required this.toolRoute,
    required this.summary,
    required this.createdAt,
  });

  factory CalculationRecord.fromJson(Map<String, dynamic> json) => CalculationRecord(
        id: json['id']?.toString() ?? '',
        tool: json['tool']?.toString() ?? 'Calculation',
        toolRoute: json['toolRoute']?.toString() ?? '',
        summary: json['summary']?.toString() ?? '',
        createdAt:
            DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
                DateTime.fromMillisecondsSinceEpoch(0),
      );

  final String id;
  final String tool;
  final String toolRoute;
  final String summary;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'tool': tool,
        'toolRoute': toolRoute,
        'summary': summary,
        'createdAt': createdAt.toIso8601String(),
      };
}

/// Persists a rolling list of recent calculations.
///
/// Backs the History screen and the "save your calculation history" feature
/// that used to be advertised but never implemented.
class HistoryService {
  const HistoryService._();

  static const int maxEntries = 200;

  /// All records, newest first.
  static List<CalculationRecord> load() {
    final String raw = SharedPrefService.historyJson;
    if (raw.isEmpty) return const <CalculationRecord>[];
    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! List) return const <CalculationRecord>[];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(CalculationRecord.fromJson)
          .toList(growable: false);
    } catch (_) {
      // Corrupt payload: start over rather than crashing on launch.
      return const <CalculationRecord>[];
    }
  }

  /// Prepends [record] and trims the list to [maxEntries].
  static Future<void> add(CalculationRecord record) async {
    final List<CalculationRecord> all = <CalculationRecord>[record, ...load()];
    await _persist(all.take(maxEntries).toList(growable: false));
  }

  static Future<void> remove(String id) async {
    final List<CalculationRecord> all =
        load().where((CalculationRecord r) => r.id != id).toList();
    await _persist(all);
  }

  static Future<void> clear() => SharedPrefService.clearHistory();

  static Future<void> _persist(List<CalculationRecord> records) =>
      SharedPrefService.setHistoryJson(
        jsonEncode(records.map((CalculationRecord r) => r.toJson()).toList()),
      );

  /// Monotonic-ish unique id.
  static String newId() =>
      DateTime.now().microsecondsSinceEpoch.toRadixString(36);
}
