import 'package:floor/floor.dart';
import 'package:weather/features/weather_forecast/domain/entity/local/place_entity.dart';

@Entity(tableName: "places_table")
class PlaceModel {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? countryCode;
  String? place;

  PlaceModel({this.id, this.countryCode, this.place});

  PlaceEntity placeModelToDomain() {
    return PlaceEntity(id, countryCode, place);
  }

  static placeModelFromJson(Map<String, dynamic> json) {
    return PlaceModel(countryCode: json['c'], place: json['ct']);
  }
}
