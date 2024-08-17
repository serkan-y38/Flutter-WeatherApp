import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/current_weather_entity.dart';

abstract class WeatherRepository {
  Future<Resource<CurrentWeatherEntity>> getCurrentWeather(String city);
}
