import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/weather_widget/build_sunrise_sunset_widget.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/weather_widget/current_weather_widget.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/weather_widget/weather_forecast_widget.dart';
import '../../../../../../../core/resource/resource.dart';
import '../../../../../domain/entity/remote/current_weather_entity.dart';
import '../../../../provider/weather_provider.dart';

Widget buildWeatherWidgets() {
  return Consumer<WeatherProvider>(
    builder: (context, provider, child) {
      if (provider.currentWeather is Loading) {
        return const Center(child: CircularProgressIndicator());

      } else if (provider.currentWeather is Error) {
        return const Center(child: Icon(Icons.error));

      } else if (provider.currentWeather is Success) {

        final weather = (provider.currentWeather as Success).data as CurrentWeatherEntity;

        return ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:return buildCurrentWeatherWidget(weather, context);
              case 1:return buildSunriseSunsetWidget(weather, context);
              case 2:return buildWeatherForecastWidget(context);
              default:return null;
            }
          },
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}
