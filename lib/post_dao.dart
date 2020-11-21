import 'package:dbsample/post.dart';
import 'package:floor/floor.dart';

@dao
abstract class PostDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOrUpdate(Post post);

  @Query('SELECT * FROM Post')
  Future<List<Post>> getAll();
}
