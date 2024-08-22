import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/features/weather_forecast/data/repository/local/place_repository_impl.dart';
import 'package:weather/features/weather_forecast/data/repository/remote/weather_repository_impl.dart';
import 'package:weather/features/weather_forecast/data/sources/remote/weather_api_service.dart';
import 'package:weather/features/weather_forecast/domain/repository/local/place_repository.dart';
import 'package:weather/features/weather_forecast/domain/repository/remote/weather_repository.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/search_place_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/insert_places_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/is_places_saved_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/remote/get_current_weather_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/remote/get_weather_forecast_use_case.dart';
import 'package:weather/features/weather_forecast/presentation/provider/current_weather_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/place_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/theme_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/weather_forecast_provider.dart';

import '../../features/weather_forecast/data/sources/local/app_database.dart';

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

  final preference = await SharedPreferences.getInstance();
  singleton.registerSingleton<ThemeProvider>(ThemeProvider(preference));

  final localDatabase =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  singleton.registerSingleton<AppDatabase>(localDatabase);

  singleton
      .registerSingleton<PlaceRepository>(PlaceRepositoryImpl(singleton()));

  singleton.registerSingleton<IsPlacesSavedUseCase>(
      IsPlacesSavedUseCase(singleton()));

  singleton.registerFactory<SearchPlaceUseCase>(
      () => SearchPlaceUseCase(singleton()));

  singleton.registerFactory<InsertPlacesUseCase>(
      () => InsertPlacesUseCase(singleton()));

  singleton.registerFactory<PlaceProvider>(
      () => PlaceProvider(singleton(), singleton(), singleton()));
}
