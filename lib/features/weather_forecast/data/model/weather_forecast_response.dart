import 'package:weather/features/weather_forecast/domain/entity/weather_response_entity.dart';

class WeatherForecastResponse {
  String? cod;
  int? message;
  int? cnt;
  List<Content>? list;
  City? city;

  WeatherForecastResponse(
      {this.cod, this.message, this.cnt, this.list, this.city});

  WeatherForecastEntity weatherForecastResponseToDomain() {
    return WeatherForecastEntity(
        list: list?.map((e) => e.contentResponseToDomain()).toList(), timezone: city?.timezone);
  }

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) {
    return WeatherForecastResponse(
        cod: json['cod'],
        message: json['message'],
        cnt: json['cnt'],
        list: (json['list'] != null)
            ? List<Content>.from(json['list'].map((e) => Content.fromJson(e)))
            : null,
        city: json['city'] != null ? City.fromJson(json['city']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class Content {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  num? pop;
  Rain? rain;
  Sys? sys;
  String? dtTxt;

  Content(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop,
      this.rain,
      this.sys,
      this.dtTxt});

  ContentEntity contentResponseToDomain() {
    return ContentEntity(
      dt: dt,
      main: main?.mainResponseToDomain(),
      weather: weather?.map((e) => e.weatherResponseToDomain()).toList(),
      sys: sys?.sysResponseToDomain(),
      wind: wind?.windResponseToDomain(),
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        dt: json['dt'],
        main: json['main'] != null ? Main.fromJson(json['main']) : null,
        weather: (json['weather'] != null)
            ? List<Weather>.from(
                json['weather'].map((e) => Weather.fromJson(e)))
            : null,
        clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
        wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
        visibility: json['visibility'],
        pop: json['pop'],
        rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
        sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
        dtTxt: json['dt_txt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    data['visibility'] = visibility;
    data['pop'] = pop;
    if (rain != null) {
      data['rain'] = rain!.toJson();
    }
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['dt_txt'] = dtTxt;
    return data;
  }
}

class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  num? tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  MainEntity mainResponseToDomain() {
    return MainEntity(temp: temp, tempMin: tempMin, tempMax: tempMax);
  }

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temp: json['temp'],
        feelsLike: json['feels_like'],
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level'],
        humidity: json['humidity'],
        tempKf: json['temp_kf']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;
    data['temp_kf'] = tempKf;
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  WeatherEntity weatherResponseToDomain() {
    return WeatherEntity(main: main, description: description, icon: icon);
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
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
}

class Clouds {
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class Wind {
  num? speed;
  int? deg;
  num? gust;

  WindEntity windResponseToDomain() {
    return WindEntity(speed: speed);
  }

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed'], deg: json['deg'], gust: json['gust']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class Rain {
  num? d3h;

  Rain({this.d3h});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(d3h: json['3h']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['3h'] = d3h;
    return data;
  }
}

class Sys {
  String? pod;

  Sys({this.pod});

  SysEntity sysResponseToDomain() {
    return SysEntity(pod: pod);
  }

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(pod: json['pod']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pod'] = pod;
    return data;
  }
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json['id'],
        name: json['name'],
        coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
        country: json['country'],
        population: json['population'],
        timezone: json['timezone'],
        sunrise: json['sunrise'],
        sunset: json['sunset']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

class Coord {
  num? lat;
  num? lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(lat: json['lat'], lon: json['lon']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
