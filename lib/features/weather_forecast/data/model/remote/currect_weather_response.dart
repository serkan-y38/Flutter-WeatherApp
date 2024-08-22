import 'package:weather/features/weather_forecast/domain/entity/remote/current_weather_entity.dart';

class CurrentWeatherResponse {
  CoordResponse? coord;
  List<WeatherResponse>? weather;
  String? base;
  MainResponse? main;
  int? visibility;
  WindResponse? wind;
  CloudsResponse? clouds;
  int? dt;
  SysResponse? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  CurrentWeatherResponse(
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

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResponse(
        coord: json['coord'] != null
            ? CoordResponse.fromJson(json['coord'])
            : null,
        weather: (json['weather'] != null)
            ? List<WeatherResponse>.from(
                json['weather'].map((x) => WeatherResponse.fromJson(x)))
            : null,
        base: json['base'],
        main: json['main'] != null ? MainResponse.fromJson(json['main']) : null,
        visibility: json['visibility'],
        wind: json['wind'] != null ? WindResponse.fromJson(json['wind']) : null,
        clouds: json['clouds'] != null
            ? CloudsResponse.fromJson(json['clouds'])
            : null,
        dt: json['dt'],
        sys: json['sys'] != null ? SysResponse.fromJson(json['sys']) : null,
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    data['base'] = base;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    data['dt'] = dt;
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }

  CurrentWeatherEntity currentWeatherResponseToDomain() {
    return CurrentWeatherEntity(
        coord: coord?.coordResponseToDomain(),
        weather: weather?.map((e) => e.weatherResponseToDomain()).toList(),
        base: base,
        main: main?.mainResponseToDomain(),
        visibility: visibility,
        wind: wind?.windResponseToDomain(),
        clouds: clouds?.cloudsResponseToDomain(),
        dt: dt,
        sys: sys?.sysResponseToDomain(),
        timezone: timezone,
        id: id,
        name: name,
        cod: cod);
  }
}

class CoordResponse {
  num? lon;
  num? lat;

  CoordResponse({this.lon, this.lat});

  factory CoordResponse.fromJson(Map<String, dynamic> json) {
    return CoordResponse(lon: json['lon'], lat: json['lat']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }

  CoordEntity coordResponseToDomain() {
    return CoordEntity(lon: lon, lat: lat);
  }
}

class WeatherResponse {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherResponse({this.id, this.main, this.description, this.icon});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }

  WeatherEntity weatherResponseToDomain() {
    return WeatherEntity(
        id: id, main: main, description: description, icon: icon);
  }
}

class MainResponse {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  MainResponse(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});

  factory MainResponse.fromJson(Map<String, dynamic> json) {
    return MainResponse(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }

  MainEntity mainResponseToDomain() {
    return MainEntity(
        temp: temp,
        feelsLike: feelsLike,
        tempMin: tempMin,
        tempMax: tempMax,
        humidity: humidity,
        pressure: pressure,
        seaLevel: seaLevel,
        grndLevel: grndLevel);
  }
}

class WindResponse {
  num? speed;
  int? deg;

  WindResponse({this.speed, this.deg});

  factory WindResponse.fromJson(Map<String, dynamic> json) {
    return WindResponse(speed: json['speed'], deg: json['deg']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    return data;
  }

  WindEntity windResponseToDomain() {
    return WindEntity(speed: speed, deg: deg);
  }
}

class CloudsResponse {
  int? all;

  CloudsResponse({this.all});

  factory CloudsResponse.fromJson(Map<String, dynamic> json) {
    return CloudsResponse(all: json['all']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }

  CloudsEntity cloudsResponseToDomain() {
    return CloudsEntity(all: all);
  }
}

class SysResponse {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  SysResponse({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory SysResponse.fromJson(Map<String, dynamic> json) {
    return SysResponse(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }

  SysEntity sysResponseToDomain() {
    return SysEntity(
        type: type, id: id, country: country, sunrise: sunrise, sunset: sunset);
  }
}
