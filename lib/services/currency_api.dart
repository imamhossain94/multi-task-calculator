import 'package:dio/dio.dart';

import '../pages/currency_calc_page/model/exchange_rate_api_response.dart';
/// Fetches live exchange rates from exchangerate-api.com.
class CurrencyApiServices {
  CurrencyApiServices({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://v6.exchangerate-api.com/v6/$_apiKey/latest/',
                receiveDataWhenStatusError: true,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  /// Access key for the public "open access" tier of exchangerate-api.com.
  static const String _apiKey = '40f0926519ff9a4d854f5799';

  final Dio _dio;

  /// Returns the rates for [code], or a response carrying an [error] message.
  ///
  /// Never throws: callers get an [ExchangeRateApiResponse] either way.
  Future<ExchangeRateApiResponse> getExchangeRate(String code) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(code);
      final dynamic data = response.data;
      if (data is! Map<String, dynamic>) {
        return ExchangeRateApiResponse.withError('Unexpected server response');
      }
      return ExchangeRateApiResponse.fromJson(data);
    } on DioException catch (e) {
      final String message = switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          'Connection timed out. Check your internet and try again.',
        DioExceptionType.connectionError =>
          'No internet connection.',
        DioExceptionType.badResponse =>
          'Server error (${e.response?.statusCode ?? '?'}).',
        _ => e.message ?? 'Request failed.',
      };
      return ExchangeRateApiResponse.withError(message);
    } catch (e) {
      return ExchangeRateApiResponse.withError('$e');
    }
  }

  /// Default currency shown on first launch.
  static const String defaultBaseCurrency = 'USD';
}
