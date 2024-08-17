import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/current_weather_entity.dart';
import 'package:weather/features/weather_forecast/domain/repository/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetCurrentWeatherUseCase(this._weatherRepository);

  Future<Resource<CurrentWeatherEntity>> call(String city) {
    return _weatherRepository.getCurrentWeather(city);
  }
}
