class CurrentWeatherEntity {
  final CoordEntity? coord;
  final List<WeatherEntity>? weather;
  final String? base;
  final MainEntity? main;
  final int? visibility;
  final WindEntity? wind;
  final CloudsEntity? clouds;
  final int? dt;
  final SysEntity? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  const CurrentWeatherEntity(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});
}

class CoordEntity {
  final num? lon;
  final num? lat;

  const CoordEntity({this.lon, this.lat});
}

class WeatherEntity {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherEntity({this.id, this.main, this.description, this.icon});
}

class MainEntity {
  final num? temp;
  final num? feelsLike;
  final num? tempMin;
  final num? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  const MainEntity(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});
}

class WindEntity {
  final num? speed;
  final int? deg;

  const WindEntity({this.speed, this.deg});
}

class CloudsEntity {
  final int? all;

  const CloudsEntity({this.all});
}

class SysEntity {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  const SysEntity(
      {this.type, this.id, this.country, this.sunrise, this.sunset});
}
