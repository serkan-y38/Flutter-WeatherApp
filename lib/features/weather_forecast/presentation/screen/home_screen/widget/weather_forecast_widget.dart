import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/utils/date_utils.dart';
import '../../../../../../core/resource/resource.dart';
import '../../../../domain/entity/weather_response_entity.dart';
import '../../../provider/weather_forecast_provider.dart';

Widget buildWeatherForecastWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Consumer<WeatherForecastProvider>(
        builder: (context, provider, child) {
          if (provider.weatherForecast is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.weatherForecast is Success) {
            final weather = (provider.weatherForecast as Success).data
                as WeatherForecastEntity;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(weather.list![index], weather.timezone!);
              },
              itemCount: weather.list!.length,
            );
          } else if (provider.weatherForecast is Error) {
            final error = (provider.weatherForecast as Error).dio;
            return Center(child: Text("Error: ${error?.error}"));
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    ),
  );
}

Widget _buildListItem(ContentEntity entity, int timeZone) {
  return ExpansionTile(
    leading: CachedNetworkImage(
      width: 32,
      height: 32,
      imageUrl:
          "https://openweathermap.org/img/wn/${entity.weather!.first.icon!}@2x.png",
      imageBuilder: (context, imageProvider) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(formatDateFromTimestamp(entity.dt! + timeZone,
            formatDateAndTime: true)),
        Text(kelvinToCelsius(entity.main!.temp!)),
      ],
    ),
    children: [
      Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${entity!.weather!.first!.main!}, ${entity!.weather!.first!.description!}"),
          Text("Wind ${entity!.wind!.speed} kp/h"),
        ],
      ),)
    ],
  );
}
