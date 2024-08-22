import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/remote/current_weather_entity.dart';
import 'package:weather/features/weather_forecast/domain/entity/remote/weather_response_entity.dart';

abstract class WeatherRepository {
  Future<Resource<CurrentWeatherEntity>> getCurrentWeather(String city);

  Future<Resource<WeatherForecastEntity>> getWeatherForecast(String city);
}
