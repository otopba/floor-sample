import 'package:dbsample/post.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(
    childColumns: ["postId"],
    parentColumns: ["id"],
    entity: Post,
    onDelete: ForeignKeyAction.cascade,
  )
])
class Trip {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int postId;

  Trip(this.id, this.postId);
}
