import 'package:flutter/cupertino.dart';
import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/current_weather_entity.dart';
import 'package:weather/features/weather_forecast/domain/use_case/remote/get_current_weather_use_case.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  final GetCurrentWeatherUseCase _currentWeatherUseCase;

  CurrentWeatherProvider(this._currentWeatherUseCase);

  Resource<CurrentWeatherEntity>? _currentWeather;

  Resource<CurrentWeatherEntity>? get currentWeather => _currentWeather;

  Future<void> getCurrentWeather(String city) async {
    _currentWeather = Loading();
    notifyListeners();

    final result = await _currentWeatherUseCase.call(city);
    _currentWeather = result;
    notifyListeners();
  }
}
