import 'dart:async';

import 'package:dbsample/post.dart';
import 'package:dbsample/post_dao.dart';
import 'package:dbsample/trip.dart';
import 'package:dbsample/trip_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [
    Post,
    Trip,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  static const _dbName = "app_database.db";

  static Future<AppDatabase> _instance;

  PostDao get postDao;

  TripDao get tripDao;

  static Future<AppDatabase> get instance =>
      _instance ??= $FloorAppDatabase.databaseBuilder(_dbName).addMigrations([
      ]).build();

}
