import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/di/di.dart';
import 'package:weather/core/navigation/navigation.dart';
import 'package:weather/features/weather_forecast/presentation/provider/current_weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentWeatherProvider>(
          create: (context) => singleton(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteClass.generateRoute,
        initialRoute: RouteNavigation.homeScreen,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
