import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/di/di.dart';
import 'package:weather/core/navigation/navigation.dart';
import 'package:weather/features/weather_forecast/presentation/provider/last_known_place_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/place_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/theme_provider.dart';
import 'package:weather/features/weather_forecast/presentation/provider/weather_provider.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WeatherProvider>(create: (context) => singleton()),
      ChangeNotifierProvider<ThemeProvider>(create: (context) => singleton()),
      ChangeNotifierProvider<PlaceProvider>(create: (context) => singleton()),
      ChangeNotifierProvider<LastKnownPlaceProvider>(create: (context) => singleton()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ThemeProvider>().getTheme();
      context.read<PlaceProvider>().isPlacesSaved();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        final theme = provider.currentTheme ?? AppTheme.systemSetting;
        return MaterialApp(
          title: 'Weather app',
          theme: ThemeUtils.getThemeData(theme, context),
          onGenerateRoute: RouteClass.generateRoute,
          initialRoute: RouteNavigation.homeScreen,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
