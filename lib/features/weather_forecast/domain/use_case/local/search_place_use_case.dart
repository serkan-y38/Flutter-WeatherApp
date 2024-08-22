import 'package:weather/core/resource/resource.dart';
import 'package:weather/features/weather_forecast/domain/entity/local/place_entity.dart';
import 'package:weather/features/weather_forecast/domain/repository/local/place_repository.dart';

class SearchPlaceUseCase {
  final PlaceRepository _placeRepository;

  SearchPlaceUseCase(this._placeRepository);

  Future<Resource<List<PlaceEntity>>> call(String query) {
    return _placeRepository.searchPlace(query);
  }
}
