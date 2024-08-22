import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../../../core/utils/date_utils.dart';
import '../../../../domain/entity/remote/current_weather_entity.dart';

Widget buildSunriseSunsetWidget(
    CurrentWeatherEntity entity, BuildContext context) {
  var sunsetMinute =
      getMinuteFromTimeStamp(entity.sys!.sunset! + entity.timezone!);
  var sunriseMinute =
      getMinuteFromTimeStamp(entity.sys!.sunrise! + entity.timezone!);

  var maxValue = sunsetMinute - sunriseMinute;
  var progress =
      getMinuteFromTimeStamp(entity.dt! + entity.timezone!) - sunriseMinute;
  if (getMinuteFromTimeStamp(entity.dt! + entity.timezone!) > sunsetMinute) {
    progress = maxValue;
  }

  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    child: Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Stack(
        children: [
          SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: maxValue.toDouble(),
                startAngle: 180,
                endAngle: 0,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.9,
                axisLineStyle: AxisLineStyle(
                  thickness: 4.0,
                  cornerStyle: CornerStyle.bothCurve,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                ),
                pointers: [
                  RangePointer(
                    value: progress.toDouble(),
                    cornerStyle: CornerStyle.bothCurve,
                    width: 4,
                    sizeUnit: GaugeSizeUnit.logicalPixel,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.1),
                  ),
                  MarkerPointer(
                    value: progress.toDouble(),
                    enableDragging: false,
                    markerHeight: 24,
                    markerWidth: 24,
                    markerType: MarkerType.circle,
                    borderWidth: 0,
                    borderColor: Colors.amber,
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 164),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.sunny,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                            ),
                            Text(
                              "Sunrise, Sunset",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                              ),
                            )
                          ],
                        ),
                        Text(
                          "${getTimeFromTimeStamp(entity.sys!.sunrise! + entity.timezone!)}, ${getTimeFromTimeStamp(entity.sys!.sunset! + entity.timezone!)}",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.my_location,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                            ),
                            Text(
                              "Latitude - Longitude",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                              ),
                            )
                          ],
                        ),
                        Text(
                          "${entity.coord!.lat!}, ${entity.coord!.lon!}",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.access_time,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                            ),
                            Text(
                              "Timezone",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                              ),
                            )
                          ],
                        ),
                        Text(
                          formatTimezone(entity.timezone!),
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.foggy,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                            ),
                            Text(
                              "Visibility",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                              ),
                            )
                          ],
                        ),
                        Text(
                          "${entity.visibility! / 1000.0} km",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    ),
  );
}
