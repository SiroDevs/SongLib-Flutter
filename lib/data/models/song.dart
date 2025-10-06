import 'package:froom/froom.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/constants/app_constants.dart';

part 'song.g.dart';

@Entity(tableName: AppConstants.songsTable)
@JsonSerializable()
class Song {
  @PrimaryKey(autoGenerate: true)
  int? rid;
  int? book;
  int? songId;
  int? songNo;
  String? title;
  String? alias;
  String? content;
  int? views;
  int? likes;
  bool? liked;
  String? created;
  String? updated;

  Song({
    this.book,
    this.songId,
    this.songNo,
    this.title,
    this.alias,
    this.content,
    this.views,
    this.likes,
    this.liked,
    this.created,
    this.updated,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}
