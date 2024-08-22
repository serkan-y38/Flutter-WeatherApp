import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/local/place_entity.dart';
import 'package:weather/features/weather_forecast/domain/repository/local/place_repository.dart';

class GetPlacesUseCase {
  final PlaceRepository _placeRepository;

  GetPlacesUseCase(this._placeRepository);

  Future<Resource<List<PlaceEntity>>> call() {
    return _placeRepository.getPlaces();
  }
}
