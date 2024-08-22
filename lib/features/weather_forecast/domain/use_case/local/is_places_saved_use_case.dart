
import 'package:weather/features/weather_forecast/domain/repository/local/place_repository.dart';

class IsPlacesSavedUseCase {
  final PlaceRepository _placeRepository;

  IsPlacesSavedUseCase(this._placeRepository);

  Future<bool?> call() {
    return _placeRepository.isPlacesSaved();
  }
}