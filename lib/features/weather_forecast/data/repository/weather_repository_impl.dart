import 'dart:io';
import 'package:dio/dio.dart';
import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/data/sources/remote/weather_api_service.dart';
import 'package:weather/features/weather_forecast/domain/entity/current_weather_entity.dart';
import 'package:weather/features/weather_forecast/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _weatherApiService;

  WeatherRepositoryImpl(this._weatherApiService);

  @override
  Future<Resource<CurrentWeatherEntity>> getCurrentWeather(String city) async {
    try {
      Loading;
      final res = await _weatherApiService.getCurrentWeather(city: city);
      if (res.response.statusCode == HttpStatus.ok) {
        var data = res.data.currentWeatherResponseToDomain();
        return Success(data);
      } else {
        return Error(DioException(
            error: res.response.statusCode,
            response: null,
            type: DioExceptionType.unknown,
            requestOptions: RequestOptions()));
      }
    } on DioException catch (e) {
      return Error(DioException(
          error: e.error,
          response: null,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions()));
    } catch (e) {
      return Error(DioException(
          error: "Unknown error: ${e.toString()}",
          response: null,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions()));
    }
  }
}
