import 'package:dio/dio.dart';
import 'package:multi_task_calculator/pages/currency_calc_page/model/exchange_rate_api_response.dart';

class CurrencyApiServices {

  Dio dio;
  CurrencyApiServices() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: 'https://v6.exchangerate-api.com/v6/40f0926519ff9a4d854f5799/latest/',
          receiveDataWhenStatusError: true,
          connectTimeout: 10*1000,
          receiveTimeout: 10*1000
      );
      dio = new Dio(options);
    }
  }

  Future<ExchangeRateApiResponse> getExchangeRate(String code) async {
    try {
      Response response = await dio.get(code,);
      final ExchangeRateApiResponse exchangeRateApiResponse = ExchangeRateApiResponse.fromJson(response.data);
      return exchangeRateApiResponse;
    }on DioError  catch (ex) {
      if(ex.type == DioErrorType.connectTimeout){
        //throw Exception("Connection  Timeout Exception");
        return ExchangeRateApiResponse.withError('Connection  Timeout Exception');
      }
      print(ex.message);
      //throw Exception(ex.message);
      return ExchangeRateApiResponse.withError(ex.message);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return ExchangeRateApiResponse.withError("$error");
    }
  }





}

