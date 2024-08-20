import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/current_weather_provider.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/app_bar.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/build_sunrise_sunset_widget.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/widget/current_weather_widget.dart';
import '../../../../../core/resource/resource.dart';
import '../../../domain/entity/current_weather_entity.dart';

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
      context.read<CurrentWeatherProvider>().getCurrentWeather("tokyo");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildGradientContainer(),
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
        headerSliverBuilder: (context, innerBoxIsScrolled) => [buildAppBar()],
        body: _buildBody());
  }

  Widget _buildBody() {
    return Consumer<CurrentWeatherProvider>(
      builder: (context, provider, child) {
        if (provider.currentWeather is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.currentWeather is Success) {
          final weather = ((provider.currentWeather as Success).data
              as CurrentWeatherEntity);
          return ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return buildCurrentWeatherWidget(weather, context);
              } else if (index == 1) {
                return buildSunriseSunsetWidget(weather, context);
              }
              return null;
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
