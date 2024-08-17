import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/current_weather_provider.dart';

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
      context.read<CurrentWeatherProvider>().getCurrentWeather("london");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Consumer<CurrentWeatherProvider>(
        builder: (context, provider, child) {
          if (provider.currentWeather is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.currentWeather is Success) {
            final weather = ((provider.currentWeather as Success).data
                as CurrentWeatherEntity);
            return Center(
                child: Text("Temperature: ${weather.main?.feelsLike.toString()}"));
          } else if (provider.currentWeather is Error) {
            final error = (provider.currentWeather as Error).dio;
            return Center(child: Text("Error: ${error?.error}"));
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CurrentWeatherProvider>().getCurrentWeather("istanbul");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
