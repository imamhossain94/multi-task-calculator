import 'exchange_rate_api.dart';

/// Wraps an [ExchangeRateApi] together with a human-readable [error].
///
/// Callers never have to handle a thrown exception: a failed request comes
/// back as a response whose [error] is non-empty and whose
/// [ExchangeRateApi.conversionRates] is empty, which is what stopped the old
/// screen from crashing when the network was down.
class ExchangeRateApiResponse {
  const ExchangeRateApiResponse(this.exchangeRateApi, this.error);

  factory ExchangeRateApiResponse.fromJson(Map<String, dynamic> json) =>
      ExchangeRateApiResponse(ExchangeRateApi.fromJson(json), '');

  factory ExchangeRateApiResponse.withError(String message) =>
      ExchangeRateApiResponse(
        const ExchangeRateApi(
          result: '',
          documentation: '',
          termsOfUse: '',
          timeLastUpdateUtc: '',
          timeNextUpdateUtc: '',
          baseCode: '',
          conversionRates: ConversionRates.empty,
        ),
        message,
      );

  final ExchangeRateApi exchangeRateApi;
  final String error;

  bool get isError => error.isNotEmpty;
}
