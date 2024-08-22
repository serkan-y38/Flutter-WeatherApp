// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PlaceDao? _placeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `places_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `countryCode` TEXT, `city` TEXT, `place` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PlaceDao get placeDao {
    return _placeDaoInstance ??= _$PlaceDao(database, changeListener);
  }
}

class _$PlaceDao extends PlaceDao {
  _$PlaceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _placeModelInsertionAdapter = InsertionAdapter(
            database,
            'places_table',
            (PlaceModel item) => <String, Object?>{
                  'id': item.id,
                  'countryCode': item.countryCode,
                  'city': item.city,
                  'place': item.place
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlaceModel> _placeModelInsertionAdapter;

  @override
  Future<bool?> isPlacesSaved({int id = 0}) async {
    return _queryAdapter.query(
        'SELECT EXISTS(SELECT 1 FROM places_table WHERE id = ?1 LIMIT 1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [id]);
  }

  @override
  Future<List<PlaceModel>> searchPlace(
    String query,
    int lastId,
    int limit,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM places_table WHERE place LIKE ?1 AND id > ?2 ORDER BY id LIMIT ?3',
        mapper: (Map<String, Object?> row) => PlaceModel(id: row['id'] as int?, countryCode: row['countryCode'] as String?, city: row['city'] as String?, place: row['place'] as String?),
        arguments: [query, lastId, limit]);
  }

  @override
  Future<void> insertPlacesBatch(List<PlaceModel> models) async {
    await _placeModelInsertionAdapter.insertList(
        models, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPlace(PlaceModel model) async {
    await _placeModelInsertionAdapter.insert(model, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertPlaces(List<PlaceModel> list) async {
    if (database is sqflite.Transaction) {
      await super.insertPlaces(list);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.placeDao.insertPlaces(list);
      });
    }
  }
}
