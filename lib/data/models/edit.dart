import 'package:froom/froom.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/constants/app_constants.dart';

part 'edit.g.dart';

@Entity(tableName: AppConstants.editsTable)
@JsonSerializable()
class Edit {
  @PrimaryKey(autoGenerate: true)
  int? rid;
  String? song;
  int? book;
  int? songNo;
  String? title;
  String? alias;
  String? content;
  String? key;
  String? created;
  String? updated;

  Edit({
    this.rid,
    this.song,
    this.book,
    this.songNo,
    this.title,
    this.alias,
    this.content,
    this.key,
    this.created,
    this.updated,
  });

  factory Edit.fromJson(Map<String, dynamic> json) => _$EditFromJson(json);

  Map<String, dynamic> toJson() => _$EditToJson(this);
}
