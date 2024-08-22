import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/navigation/navigation.dart';
import 'package:weather/features/weather_forecast/presentation/provider/weather_provider.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/app_bar_widget.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/build_sunrise_sunset_widget.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/current_weather_widget.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/place_search_delegate.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/weather_forecast_widget.dart';
import '../../../../../core/resource/resource.dart';
import '../../../domain/entity/remote/current_weather_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().getCurrentWeather("tokyo");
      context.read<WeatherProvider>().getWeatherForecast("tokyo");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: _buildGradientContainer(),
    ));
  }

  Widget _buildGradientContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          stops: const [
            0.01,
            0.3,
            0.9,
          ],
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: _buildScreenContents(),
    );
  }

  Widget _buildScreenContents() {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              buildAppBar(
                  onSettingsClicked: () => Navigator.pushNamed(
                      context, RouteNavigation.settingsScreen),
                  onSearchClicked: () {
                    showSearch(
                        context: context,
                        delegate: PlaceSearchDelegate(onPlaceSelected: (place) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context
                                .read<WeatherProvider>()
                                .getCurrentWeather(place);
                            context
                                .read<WeatherProvider>()
                                .getWeatherForecast(place);
                          });
                        }));
                  })
            ],
        body: _buildBody());
  }

  Widget _buildBody() {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        if (provider.currentWeather is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.currentWeather is Success) {
          final weather =
              (provider.currentWeather as Success).data as CurrentWeatherEntity;

          return ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return buildCurrentWeatherWidget(weather, context);
                case 1:
                  return buildSunriseSunsetWidget(weather, context);
                case 2:
                  return buildWeatherForecastWidget(context);
                default:
                  return null;
              }
            },
          );
        } else if (provider.currentWeather is Error) {
          final error = (provider.currentWeather as Error).dio;
          return Center(child: Text("Error: ${error?.error}"));
        } else {
          return const Center(child: Text("No data"));
        }
      },
    );
  }
}
