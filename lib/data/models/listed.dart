import 'package:froom/froom.dart';

import '../../core/utils/constants/app_constants.dart';

@Entity(tableName: AppConstants.listedsTable)
class Listed {
  @PrimaryKey(autoGenerate: true)
  int? rid;
  int? parentid;
  int? song;
  String? title;
  String? description;
  int? position;
  String? created;
  String? updated;

  Listed({
    this.rid,
    this.parentid,
    this.song,
    this.title,
    this.description,
    this.position,
    this.created,
    this.updated,
  });
}
