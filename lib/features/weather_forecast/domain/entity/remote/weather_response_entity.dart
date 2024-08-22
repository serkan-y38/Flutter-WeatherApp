class WeatherForecastEntity {
  List<ContentEntity>? list;
  int? timezone;

  WeatherForecastEntity({this.list, this.timezone});
}

class ContentEntity {
  int? dt;
  MainEntity? main;
  List<WeatherEntity>? weather;
  WindEntity? wind;
  SysEntity? sys;

  ContentEntity({this.dt, this.main, this.weather, this.wind, this.sys});
}

class MainEntity {
  num? temp;
  num? tempMin;
  num? tempMax;

  MainEntity({this.temp, this.tempMin, this.tempMax});
}

class WeatherEntity {
  String? main;
  String? description;
  String? icon;

  WeatherEntity({this.main, this.description, this.icon});
}

class WindEntity {
  num? speed;

  WindEntity({this.speed});
}

class SysEntity {
  String? pod;

  SysEntity({this.pod});
}
