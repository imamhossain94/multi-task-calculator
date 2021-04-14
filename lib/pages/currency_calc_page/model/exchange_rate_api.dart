import 'package:multi_task_calculator/pages/currency_calc_page/model/conversion_rates.dart';

class ExchangeRateApi {
  final String result;
  final String documentation;
  final String termsOfUse;
  final String timeLastUpdateUnix;
  final String timeLastUpdateUtc;
  final String timeNextUpdateUnix;
  final String timeNextUpdateUtc;
  final String baseCode;
  final ConversionRates conversionRates;

  ExchangeRateApi(
      {this.result,
        this.documentation,
        this.termsOfUse,
        this.timeLastUpdateUnix,
        this.timeLastUpdateUtc,
        this.timeNextUpdateUnix,
        this.timeNextUpdateUtc,
        this.baseCode,
        this.conversionRates});

  ExchangeRateApi.fromJson(Map<String, dynamic> json) :
    result = json['result'].toString(),
    documentation = json['documentation'].toString(),
    termsOfUse = json['terms_of_use'].toString(),
    timeLastUpdateUnix = json['time_last_update_unix'].toString(),
    timeLastUpdateUtc = json['time_last_update_utc'].toString(),
    timeNextUpdateUnix = json['time_next_update_unix'].toString(),
    timeNextUpdateUtc = json['time_next_update_utc'].toString(),
    baseCode = json['base_code'].toString(),
    conversionRates = json['conversion_rates'] != null ? new ConversionRates.fromJson(json['conversion_rates']) : null;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['documentation'] = this.documentation;
    data['terms_of_use'] = this.termsOfUse;
    data['time_last_update_unix'] = this.timeLastUpdateUnix;
    data['time_last_update_utc'] = this.timeLastUpdateUtc;
    data['time_next_update_unix'] = this.timeNextUpdateUnix;
    data['time_next_update_utc'] = this.timeNextUpdateUtc;
    data['base_code'] = this.baseCode;
    if (this.conversionRates != null) {
      data['conversion_rates'] = this.conversionRates.toJson();
    }
    return data;
  }
}



class CurrencyRates{
  final String code, symbol, flag, definition, rates;
  CurrencyRates({this.symbol, this.flag, this.definition, this.code, this.rates});
}