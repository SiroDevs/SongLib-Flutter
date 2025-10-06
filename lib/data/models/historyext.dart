import 'package:froom/froom.dart';

import '../../core/utils/constants/app_constants.dart';

@DatabaseView(
  '${AppConstants.historyExtSql};',
  viewName: AppConstants.historiesTableViews,
)
class HistoryExt {
  int rid;
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

  HistoryExt(
    this.rid,
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
