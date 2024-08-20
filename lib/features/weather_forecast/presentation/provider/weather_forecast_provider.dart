import 'package:flutter/cupertino.dart';
import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/weather_response_entity.dart';
import 'package:weather/features/weather_forecast/domain/use_case/remote/get_weather_forecast_use_case.dart';

class WeatherForecastProvider with ChangeNotifier {
  final GetWeatherForecastUseCase _getWeatherForecastUseCase;

  WeatherForecastProvider(this._getWeatherForecastUseCase);

  Resource<WeatherForecastEntity>? _weatherForecast;

  Resource<WeatherForecastEntity>? get weatherForecast => _weatherForecast;

  Future<void> getWeatherForecast(String city) async {
    _weatherForecast = Loading();
    notifyListeners();

    final response = await _getWeatherForecastUseCase.call(city);
    _weatherForecast = response;
    notifyListeners();
  }
}
