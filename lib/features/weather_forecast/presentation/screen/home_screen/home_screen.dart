import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/navigation/navigation.dart';
import 'package:weather/core/utils/snack_bar_utils.dart';
import 'package:weather/features/weather_forecast/presentation/provider/last_known_place_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/weather_provider.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/app_bar_widget.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/weather_widget/build_weather_widgets.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/place_search_delegate.dart';

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
      context.read<LastKnownPlaceProvider>().getLastKnownPlace();
    });
    checkLocationPermission(context);
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
                        delegate: PlaceSearchDelegate(context,
                            onPlaceSelected: (place) => context
                                .read<LastKnownPlaceProvider>()
                                .setPlace(place),
                            onCurrentLocation: () =>
                                checkLocationPermission(context)));
                  })
            ],
        body: _buildBody());
  }

  Widget _buildBody() {
    return Consumer<LastKnownPlaceProvider>(
      builder: (context, provider, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context
              .read<WeatherProvider>()
              .getCurrentWeather(provider.place ?? "");
          context
              .read<WeatherProvider>()
              .getWeatherForecast(provider.place ?? "");
        });
        return buildWeatherWidgets();
      },
    );
  }

  Future<void> checkLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.denied:
        var permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            buildSnackBar(context, 'Permission denied');
          });
        } else if (permission == LocationPermission.deniedForever) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            buildSnackBarWithAction(
                context, 'Permission denied forever, open app settings', 'OPEN',
                onActionClicked: () {
              AppSettings.openAppSettings();
            });
          });
        } else if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<LastKnownPlaceProvider>().getPlaceFromLocation();
          });
        }
        break;

      case LocationPermission.deniedForever:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buildSnackBarWithAction(
              context, 'Permission denied forever, open app settings', 'OPEN',
              onActionClicked: () {
            AppSettings.openAppSettings();
          });
        });
        break;

      case LocationPermission.whileInUse || LocationPermission.always:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<LastKnownPlaceProvider>().getPlaceFromLocation();
        });
        break;

      case LocationPermission.unableToDetermine:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buildSnackBar(context, 'Oops, something went wrong!');
        });
        break;
    }
  }
}
