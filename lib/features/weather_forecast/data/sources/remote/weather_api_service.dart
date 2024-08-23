import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather/core/constant/api_key.dart';
import 'package:weather/core/constant/constants.dart';
import 'package:weather/features/weather_forecast/data/model/remote/weather_forecast_response.dart';
import '../../model/remote/currect_weather_response.dart';

/** dart run build_runner build */
part 'weather_api_service.g.dart';

@RestApi(baseUrl: weatherApiBaseUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET("/weather")
  Future<HttpResponse<CurrentWeatherResponse>> getCurrentWeather(
      {@Query("appid") String? key = apiKey, @Query("q") String? city});

  @GET("/forecast")
  Future<HttpResponse<WeatherForecastResponse>> getWeatherForecast(
      {@Query("appid") String? key = apiKey, @Query("q") String? city});
}
