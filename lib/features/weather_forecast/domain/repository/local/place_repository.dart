import 'package:weather/features/weather_forecast/domain/entity/local/place_entity.dart';

import '../../../../../core/resource/resource.dart';

abstract class PlaceRepository {
  Future<Resource<List<PlaceEntity>>> getPlaces();

  Future<void> insertPlaces();

  Future<bool?> isPlacesSaved();
}
