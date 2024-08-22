import 'package:flutter/foundation.dart';
import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/local/place_entity.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/insert_places_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/is_places_saved_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/search_place_use_case.dart';

class PlaceProvider extends ChangeNotifier {
  final IsPlacesSavedUseCase _isPlacesSavedUseCase;
  final InsertPlacesUseCase _insertPlacesUseCase;
  final SearchPlaceUseCase _searchPlaceUseCase;

  PlaceProvider(this._isPlacesSavedUseCase, this._insertPlacesUseCase,
      this._searchPlaceUseCase);

  Resource<List<PlaceEntity>>? _searchResult;

  Resource<List<PlaceEntity>>? get searchResult => _searchResult;

  Future<void> isPlacesSaved() async {
    final result = await _isPlacesSavedUseCase.call();

    if (result != null && !result) insertPlaces();
    notifyListeners();
  }

  Future<void> insertPlaces() async {
    await _insertPlacesUseCase.call();
  }

  Future<void> searchPlace(String query) async {
    _searchResult = Loading();
    notifyListeners();

    final result = await _searchPlaceUseCase.call(query);
    _searchResult = result;
    notifyListeners();
  }

  Future<void> clearSearchResult() async {
    _searchResult = null;
    notifyListeners();
  }
}
