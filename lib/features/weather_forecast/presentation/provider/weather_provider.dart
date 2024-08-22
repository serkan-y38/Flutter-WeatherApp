import 'package:flutter/cupertino.dart';
import '../../../../core/resource/resource.dart';
import '../../domain/entity/remote/current_weather_entity.dart';
import '../../domain/entity/remote/weather_response_entity.dart';
import '../../domain/use_case/remote/get_current_weather_use_case.dart';
import '../../domain/use_case/remote/get_weather_forecast_use_case.dart';

class WeatherProvider extends ChangeNotifier {
  final GetCurrentWeatherUseCase _currentWeatherUseCase;
  final GetWeatherForecastUseCase _getWeatherForecastUseCase;

  WeatherProvider(this._getWeatherForecastUseCase, this._currentWeatherUseCase);

  Resource<CurrentWeatherEntity>? _currentWeather;

  Resource<CurrentWeatherEntity>? get currentWeather => _currentWeather;

  Future<void> getCurrentWeather(String city) async {
    _currentWeather = Loading();
    notifyListeners();

    final result = await _currentWeatherUseCase.call(city);
    _currentWeather = result;
    notifyListeners();
  }

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
