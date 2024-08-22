import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/utils/date_utils.dart';
import '../../../../../../core/resource/resource.dart';
import '../../../../domain/entity/remote/weather_response_entity.dart';
import '../../../provider/weather_provider.dart';

Widget buildWeatherForecastWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          if (provider.weatherForecast is Loading) {
            return const SizedBox();
          } else if (provider.weatherForecast is Success) {
            final weather = (provider.weatherForecast as Success).data
                as WeatherForecastEntity;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(
                    weather.list![index], weather.timezone!, context);
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

Widget _buildListItem(
    ContentEntity entity, int timeZone, BuildContext context) {
  return ExpansionTile(
    leading: CachedNetworkImage(
      width: 36,
      height: 36,
      imageUrl:
          "https://openweathermap.org/img/wn/${entity.weather!.first.icon!}@2x.png",
      imageBuilder: (context, imageProvider) => Container(
        width: 36,
        height: 36,
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
        Text(
          formatDateFromTimestamp(entity.dt! + timeZone,
              formatDateAndTime: true),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        Text(
          "${kelvinToCelsius(entity.main!.temp!)}°C",
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    ),
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${entity.weather!.first.main!}, ${entity.weather!.first.description!}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            Text(
              "Wind ${entity.wind!.speed} kp/h",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      )
    ],
  );
}
