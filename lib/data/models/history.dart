import 'package:froom/froom.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/constants/app_constants.dart';

@Entity(tableName: AppConstants.historiesTable)
@JsonSerializable()
class History {
  @PrimaryKey(autoGenerate: true)
  int? rid;
  int? song;
  String? created;

  History({
    this.rid,
    this.song,
    this.created,
  });
}
