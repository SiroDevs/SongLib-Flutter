import 'dart:async';

import 'package:froom/froom.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../core/utils/app_util.dart';
import '../../models/models.dart';
import 'dao/books_dao.dart';
import 'dao/drafts_dao.dart';
import 'dao/edits_dao.dart';
import 'dao/histories_dao.dart';
import 'dao/listeds_dao.dart';
import 'dao/searches_dao.dart';
import 'dao/songs_dao.dart';

part 'app_database.g.dart';

@Database(
  version: 2,
  entities: [
    Book,
    Draft,
    Edit,
    History,
    Listed,
    Search,
    Song,
  ],
  views: [HistoryExt, ListedExt, SongExt],
)
abstract class AppDatabase extends FroomDatabase {
  BooksDao get booksDao;
  DraftsDao get draftsDao;
  EditsDao get editsDao;
  HistoriesDao get historiesDao;
  ListedsDao get listedsDao;
  SearchesDao get searchesDao;
  SongsDao get songsDao;
}

final addDraftsListedsTables = Migration(1, 2, (database) async {
  logger("Add drafts and listeds tables");
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `drafts` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `songId` INTEGER, `songNo` INTEGER, `title` TEXT, `alias` TEXT, `content` TEXT, `views` INTEGER, `likes` INTEGER, `liked` INTEGER, `created` TEXT, `updated` TEXT)',
  );
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `listeds` (`rid` INTEGER PRIMARY KEY AUTOINCREMENT, `parentid` INTEGER, `song` INTEGER, `title` TEXT, `description` TEXT, `position` INTEGER, `created` TEXT, `updated` TEXT)',
  );
});

final migrations = [addDraftsListedsTables];

Future<AppDatabase> buildInMemoryDatabase() {
  return $FloorAppDatabase
      .inMemoryDatabaseBuilder()
      .addMigrations(migrations)
      
      .build();
}
