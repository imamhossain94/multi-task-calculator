import '../../../utils/constant.dart';

/// Exchange-rate API payload.
///
/// `conversion_rates` is a flat `{"USD": 1.0, "EUR": 0.92, ...}` map, so it is
/// kept as a `Map<String, double>` instead of the ~160 hand-written fields the
/// previous version carried. That also removes the fragile
/// `entries.elementAt(142)` lookups that silently picked the wrong currency.
class ExchangeRateApi {
  const ExchangeRateApi({
    required this.result,
    required this.documentation,
    required this.termsOfUse,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUtc,
    required this.baseCode,
    required this.conversionRates,
  });

  factory ExchangeRateApi.fromJson(Map<String, dynamic> json) {
    return ExchangeRateApi(
      result: json['result']?.toString() ?? '',
      documentation: json['documentation']?.toString() ?? '',
      termsOfUse: json['terms_of_use']?.toString() ?? '',
      timeLastUpdateUtc: json['time_last_update_utc']?.toString() ?? '',
      timeNextUpdateUtc: json['time_next_update_utc']?.toString() ?? '',
      baseCode: json['base_code']?.toString() ?? '',
      conversionRates: ConversionRates.fromJson(json['conversion_rates']),
    );
  }

  final String result;
  final String documentation;
  final String termsOfUse;
  final String timeLastUpdateUtc;
  final String timeNextUpdateUtc;
  final String baseCode;
  final ConversionRates conversionRates;
}

/// A `Map<String, double>` of currency code -> rate, with a display-friendly
/// [CurrencyRates] view for the UI.
class ConversionRates {
  const ConversionRates(this.rates);

  factory ConversionRates.fromJson(Object? json) {
    if (json is! Map) return const ConversionRates(<String, double>{});
    final Map<String, double> parsed = <String, double>{};
    json.forEach((Object? key, Object? value) {
      if (key is String && value is num) {
        parsed[key.toUpperCase()] = value.toDouble();
      }
    });
    return ConversionRates(parsed);
  }

  static const ConversionRates empty = ConversionRates(<String, double>{});

  final Map<String, double> rates;

  bool get isEmpty => rates.isEmpty;

  bool get isNotEmpty => rates.isNotEmpty;

  int get length => rates.length;

  /// Rate for [code] relative to the base currency, or `null` when unknown.
  double? rateFor(String code) => rates[code.toUpperCase()];

  /// A sorted, display-ready list scaled by [amount].
  ///
  /// [amount] is the value in the base currency; every entry is that value
  /// expressed in the row's currency. Sorted by code so the list order stays
  /// stable between rebuilds.
  List<CurrencyRates> toList({double amount = 1}) {
    final List<MapEntry<String, double>> entries = rates.entries.toList()
      ..sort(
        (MapEntry<String, double> a, MapEntry<String, double> b) =>
            a.key.compareTo(b.key),
      );
    return entries
        .map(
          (MapEntry<String, double> e) => CurrencyRates(
            code: e.key,
            definition: currencyCodeList[e.key] ?? e.key,
            rates: (e.value * amount).toString(),
          ),
        )
        .toList(growable: false);
  }
}

/// One row in the currency list.
class CurrencyRates {
  const CurrencyRates({
    this.symbol,
    this.flag,
    this.definition,
    this.code,
    this.rates,
  });

  final String? symbol;
  final String? flag;
  final String? definition;
  final String? code;
  final String? rates;
}
