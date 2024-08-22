import 'package:floor/floor.dart';
import 'package:weather/features/weather_forecast/data/model/local/place_model.dart';

@dao
abstract class PlaceDao {
  @transaction
  Future<void> insertPlaces(List<PlaceModel> list) async {
    for (var i = 0; i < list.length; i += 200) {
      final batch = list.skip(i).take(200).toList();
      await insertPlacesBatch(batch);
    }
  }

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPlacesBatch(List<PlaceModel> models);

  @Insert()
  Future<void> insertPlace(PlaceModel model);

  @Query('SELECT EXISTS(SELECT 1 FROM places_table WHERE id = :id LIMIT 1)')
  Future<bool?> isPlacesSaved({int id = 1});

  @Query("SELECT * FROM places_table WHERE place LIKE :query")
  Future<List<PlaceModel>> searchPlace(String query);
}
