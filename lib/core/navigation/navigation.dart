import 'package:flutter/material.dart';
import 'package:weather/features/weather_forecast/presentation/screen/home_screen/home_screen.dart';

class RouteNavigation {
  static const String homeScreen = "homeScreen";
}

class RouteClass {
  static Route<dynamic> generateRoute(RouteSettings rs) {
    switch (rs.name) {
      case RouteNavigation.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${rs.name}')),
                ));
    }
  }
}
