import 'dart:async';

import 'package:dbsample/trip.dart';
import 'package:floor/floor.dart';

@dao
abstract class TripDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOrUpdate(Trip trip);

  @Query('SELECT * FROM Trip')
  Future<List<Trip>> getAll();
}
