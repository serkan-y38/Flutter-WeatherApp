import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/utils/date_utils.dart';
import '../../../../domain/entity/current_weather_entity.dart';

Widget buildCurrentWeatherWidget(
    CurrentWeatherEntity entity, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.date_range),
                          ),
                          Text(
                              "${getDayOfWeek(entity.dt.toString())}, ${formatDateFromTimestamp(entity.dt! + entity.timezone!)}")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.location_city),
                          ),
                          Text("${entity.sys!.country!} - ${entity.name!}")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.wb_cloudy_rounded),
                          ),
                          Text(entity.weather!.first.description!)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "${kelvinToCelsius(entity.main!.feelsLike!)}°C",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://openweathermap.org/img/wn/${entity.weather!.first.icon!}@2x.png",
                      imageBuilder: (context, imageProvider) => Container(
                        width: 148,
                        height: 148,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        "assets/raindrops_dark.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                    Text("%${entity.main!.humidity}")
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        "assets/wind_dark.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                    Text("${entity.wind!.speed} kp/h")
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        "assets/pressure_dark.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                    Text("${entity.main!.pressure} hPa")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
