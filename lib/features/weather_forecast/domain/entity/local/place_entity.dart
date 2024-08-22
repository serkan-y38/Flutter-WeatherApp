import 'package:weather/features/weather_forecast/data/model/local/place_model.dart';

class PlaceEntity {
  int? id;
  String? countryCode;
  String? place;

  PlaceEntity(this.id, this.countryCode, this.place);

  PlaceModel placeModelToData() {
    return PlaceModel(id: id, countryCode: countryCode, place: place);
  }
}
