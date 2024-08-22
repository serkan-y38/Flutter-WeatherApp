import 'package:dio/dio.dart';
import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/local/place_entity.dart';
import 'package:weather/features/weather_forecast/domain/repository/local/place_repository.dart';
import '../../model/local/place_model.dart';
import '../../sources/local/app_database.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PlaceRepositoryImpl implements PlaceRepository {
  final AppDatabase _appDatabase;

  PlaceRepositoryImpl(this._appDatabase);

  @override
  Future<Resource<List<PlaceEntity>>> getPlaces() async {
    try {
      Loading;
      final places = await _appDatabase.placeDao.getPlaces();
      return Success(places.map((e) => e.placeModelToDomain()).toList());
    } on DioException catch (e) {
      return Error(DioException(
          error: e.error,
          response: null,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions()));
    }
  }

  @override
  Future<bool?> isPlacesSaved() async {
    return _appDatabase.placeDao.isPlacesSaved();
  }

  @override
  Future<void> insertPlaces() async {
    String citiesJson = await rootBundle.loadString('assets/cities.json');

    List<PlaceModel> citiesList = List<PlaceModel>.from(json
        .decode(citiesJson)
        .map((e) => PlaceModel.placeModelFromJson(e))).toList();

    await _appDatabase.placeDao.insertPlaces(citiesList);
  }
}
