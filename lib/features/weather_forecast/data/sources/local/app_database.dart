import 'dart:async';
import 'package:floor/floor.dart';
import 'package:weather/features/weather_forecast/data/model/local/place_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/place_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [PlaceModel])
abstract class AppDatabase extends FloorDatabase {
  PlaceDao get placeDao;
}
