// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PostDao _postDaoInstance;

  TripDao _tripDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `Post` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `someValue` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Trip` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `postId` INTEGER, FOREIGN KEY (`postId`) REFERENCES `Post` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PostDao get postDao {
    return _postDaoInstance ??= _$PostDao(database, changeListener);
  }

  @override
  TripDao get tripDao {
    return _tripDaoInstance ??= _$TripDao(database, changeListener);
  }
}

class _$PostDao extends PostDao {
  _$PostDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _postInsertionAdapter = InsertionAdapter(
            database,
            'Post',
            (Post item) =>
                <String, dynamic>{'id': item.id, 'someValue': item.someValue});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Post> _postInsertionAdapter;

  @override
  Future<List<Post>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Post',
        mapper: (Map<String, dynamic> row) =>
            Post(row['id'] as int, row['someValue'] as String));
  }

  @override
  Future<int> insertOrUpdate(Post post) {
    return _postInsertionAdapter.insertAndReturnId(
        post, OnConflictStrategy.replace);
  }
}

class _$TripDao extends TripDao {
  _$TripDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _tripInsertionAdapter = InsertionAdapter(
            database,
            'Trip',
            (Trip item) =>
                <String, dynamic>{'id': item.id, 'postId': item.postId});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Trip> _tripInsertionAdapter;

  @override
  Future<List<Trip>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Trip',
        mapper: (Map<String, dynamic> row) =>
            Trip(row['id'] as int, row['postId'] as int));
  }

  @override
  Future<int> insertOrUpdate(Trip trip) {
    return _tripInsertionAdapter.insertAndReturnId(
        trip, OnConflictStrategy.replace);
  }
}
