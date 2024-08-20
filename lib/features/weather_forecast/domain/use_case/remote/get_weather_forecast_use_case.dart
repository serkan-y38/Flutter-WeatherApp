import 'package:weather/features/weather_forecast/domain/entity/weather_response_entity.dart';
import '../../../../../core/resource/resource.dart';
import '../../repository/weather_repository.dart';

class GetWeatherForecastUseCase {
  final WeatherRepository _weatherRepository;

  GetWeatherForecastUseCase(this._weatherRepository);

  Future<Resource<WeatherForecastEntity>> call(String city) {
    return _weatherRepository.getWeatherForecast(city);
  }
}
