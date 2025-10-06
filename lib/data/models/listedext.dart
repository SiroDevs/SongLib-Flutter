import 'package:froom/froom.dart';

import '../../core/utils/constants/app_constants.dart';

@DatabaseView(
  '${AppConstants.listedExtSql};',
  viewName: AppConstants.listedsTableViews,
)
class ListedExt {
  int rid;
  int parentid;
  int position;
  String created;
  String updated;
  int book;
  int songId;
  int songNo;
  String title;
  String alias;
  String content;
  int views;
  int likes;
  bool liked;
  String songbook;

  ListedExt(
    this.rid,
    this.parentid,
    this.position,
    this.created,
    this.updated,
    this.book,
    this.songId,
    this.songNo,
    this.title,
    this.alias,
    this.content,
    this.views,
    this.likes,
    this.liked,
    this.songbook,
  );
}
