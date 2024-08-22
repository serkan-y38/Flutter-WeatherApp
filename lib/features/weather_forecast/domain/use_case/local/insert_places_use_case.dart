import '../../repository/local/place_repository.dart';

class InsertPlacesUseCase {
  final PlaceRepository _placeRepository;

  InsertPlacesUseCase(this._placeRepository);

  Future<void> call() {
    return _placeRepository.insertPlaces();
  }
}
