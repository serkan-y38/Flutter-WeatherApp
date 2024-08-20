import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/di/di.dart';
import 'package:weather/core/navigation/navigation.dart';
import 'package:weather/features/weather_forecast/presentation/provider/current_weather_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/weather_forecast_provider.dart';

import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentWeatherProvider>(
          create: (context) => singleton(),
        ),
        ChangeNotifierProvider<WeatherForecastProvider>(
            create: (context) => singleton())
      ],
      child: MaterialApp(
        title: 'Weather app',
        theme: darkTheme,
        onGenerateRoute: RouteClass.generateRoute,
        initialRoute: RouteNavigation.homeScreen,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
