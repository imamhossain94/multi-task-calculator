
import 'package:multi_task_calculator/pages/currency_calc_page/model/exchange_rate_api.dart';

class ExchangeRateApiResponse{

  final ExchangeRateApi exchangeRateApi;
  final String error;

  ExchangeRateApiResponse(this.exchangeRateApi, this.error);

  ExchangeRateApiResponse.fromJson(dynamic json)
      : exchangeRateApi = ExchangeRateApi.fromJson(json),
        error = "";

  ExchangeRateApiResponse.withError(String errorValue)
      : exchangeRateApi = ExchangeRateApi(),
        error = errorValue;

}