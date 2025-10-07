import 'dart:async';

import 'package:froom/froom.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

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
  version: 3,
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

Future<AppDatabase> buildInMemoryDatabase() {
  return $FroomAppDatabase
      .inMemoryDatabaseBuilder()
      .build();
}
