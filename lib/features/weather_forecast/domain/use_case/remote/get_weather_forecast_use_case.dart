import 'package:weather/features/weather_forecast/domain/entity/remote/weather_response_entity.dart';
import '../../../../../core/resource/resource.dart';
import '../../repository/remote/weather_repository.dart';

class GetWeatherForecastUseCase {
  final WeatherRepository _weatherRepository;

  GetWeatherForecastUseCase(this._weatherRepository);

  Future<Resource<WeatherForecastEntity>> call(String city) {
    return _weatherRepository.getWeatherForecast(city);
  }
}
