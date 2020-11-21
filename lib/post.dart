import 'package:floor/floor.dart';

@entity
class Post {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String someValue;

  Post(this.id, this.someValue);
}
