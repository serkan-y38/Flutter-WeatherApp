import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather/core/constant/api_key.dart';
import 'package:weather/core/constant/constents.dart';
import '../../model/currect_weather_response.dart';

part 'weather_api_service.g.dart';

@RestApi(baseUrl: weatherApiBaseUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET("/weather")
  Future<HttpResponse<CurrentWeatherResponse>> getCurrentWeather(
      {@Query("appid") String? key = apiKey, @Query("q") String? city});
}
