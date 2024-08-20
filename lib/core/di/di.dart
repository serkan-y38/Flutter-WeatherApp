import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/features/weather_forecast/data/repository/weather_repository_impl.dart';
import 'package:weather/features/weather_forecast/data/sources/remote/weather_api_service.dart';
import 'package:weather/features/weather_forecast/domain/repository/weather_repository.dart';
import 'package:weather/features/weather_forecast/domain/use_case/remote/get_current_weather_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/remote/get_weather_forecast_use_case.dart';
import 'package:weather/features/weather_forecast/presentation/provider/current_weather_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/weather_forecast_provider.dart';

final singleton = GetIt.instance;

Future<void> initializeDependencies() async {
  singleton.registerSingleton<Dio>(Dio());

  singleton
      .registerSingleton<WeatherApiService>(WeatherApiService(singleton()));

  singleton
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(singleton()));

  singleton.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(singleton()));

  singleton.registerSingleton<GetWeatherForecastUseCase>(
      GetWeatherForecastUseCase(singleton()));

  singleton.registerFactory<CurrentWeatherProvider>(
      () => CurrentWeatherProvider(singleton()));

  singleton.registerFactory<WeatherForecastProvider>(
      () => WeatherForecastProvider(singleton()));
}
