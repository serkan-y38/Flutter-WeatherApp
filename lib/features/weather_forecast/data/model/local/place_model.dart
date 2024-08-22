import 'package:floor/floor.dart';
import 'package:weather/features/weather_forecast/domain/entity/local/place_entity.dart';

@Entity(tableName: "places_table")
class PlaceModel {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? countryCode;
  String? city;
  String? place;

  PlaceModel({this.id, this.countryCode, this.city, this.place});

  PlaceEntity placeModelToDomain() {
    return PlaceEntity(id: id, countryCode: countryCode, city: city, place: place);
  }

  static placeModelFromJson(Map<String, dynamic> json) {
    return PlaceModel(
        countryCode: json['cc'], city: json['c'], place: json['p']);
  }
}
