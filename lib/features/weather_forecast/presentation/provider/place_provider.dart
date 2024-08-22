import 'package:flutter/foundation.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/insert_places_use_case.dart';
import 'package:weather/features/weather_forecast/domain/use_case/local/is_places_saved_use_case.dart';

class PlaceProvider extends ChangeNotifier {
  final IsPlacesSavedUseCase _isPlacesSavedUseCase;
  final InsertPlacesUseCase _insertPlacesUseCase;

  PlaceProvider(this._isPlacesSavedUseCase, this._insertPlacesUseCase);

  Future<void> isPlacesSaved() async {
    final result = await _isPlacesSavedUseCase.call();

    if (result != null && !result) insertPlaces();
    notifyListeners();
  }

  Future<void> insertPlaces() async {
    await _insertPlacesUseCase.call();
  }
}
