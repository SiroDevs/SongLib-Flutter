import '../models/models.dart';
import '../sources/local/app_database.dart';
import 'database_repository.dart';

/// Implementor of Database Repository
class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDB;

  DatabaseRepositoryImpl(this._appDB);

  @override
  Future<List<Book>> fetchBooks() async {
    return _appDB.booksDao.fetchBooks();
  }

  @override
  Future<void> removeBook(Book book) async {
    return _appDB.booksDao.deleteBook(book);
  }

  @override
  Future<void> saveBook(Book book) async {
    return _appDB.booksDao.insertBook(book);
  }

  @override
  Future<void> removeAllBooks() async {
    return _appDB.booksDao.deleteAllBooks();
  }

  @override
  Future<Song?> findSongById(int rid) async {
    return _appDB.songsDao.findSongById(rid);
  }

  @override
  Future<List<SongExt>> fetchSongs({int bid = 0}) async {
    late Stream<List<SongExt>> streams;
    if (bid == 0) {
      streams = _appDB.songsDao.fetchAllSongs();
    } else {
      streams = _appDB.songsDao.fetchSongs(bid);
    }
    return await streams.first;
  }

  @override
  Future<List<SongExt>> fetchLikes() async {
    final Stream<List<SongExt>> streams = _appDB.songsDao.fetchLikes();
    return await streams.first;
  }

  @override
  Future<void> removeSong(Song song) async {
    return _appDB.songsDao.deleteSong(song);
  }

  @override
  Future<void> saveSong(Song song) async {
    return _appDB.songsDao.insertSong(song);
  }

  @override
  Future<void> updateSong(
    int rid,
    String title,
    String content,
    bool liked,
    String updated,
  ) async {
    return _appDB.songsDao.updateSong(rid, title, content, liked, updated);
  }

  @override
  Future<void> syncSong(
    int songId,
    String title,
    String alias,
    String content,
  ) async {
    return _appDB.songsDao.syncSong(songId, title, alias, content);
  }

  @override
  Future<void> removeAllSongs() async {
    return _appDB.songsDao.deleteAllSongs();
  }

  @override
  Future<List<Edit>> fetchEdits() async {
    return _appDB.editsDao.fetchEdits();
  }

  @override
  Future<void> removeEdit(Edit edit) async {
    return _appDB.editsDao.deleteEdit(edit);
  }

  @override
  Future<void> saveEdit(Edit edit) async {
    return _appDB.editsDao.insertEdit(edit);
  }

  @override
  Future<void> removeAllEdits() async {
    return _appDB.editsDao.deleteAllEdits();
  }

  @override
  Future<List<Draft>> fetchDrafts() async {
    return _appDB.draftsDao.fetchDrafts();
  }

  @override
  Future<void> removeDraft(Draft draft) async {
    return _appDB.draftsDao.deleteDraft(draft);
  }

  @override
  Future<void> saveDraft(Draft draft) async {
    return _appDB.draftsDao.insertDraft(draft);
  }

  @override
  Future<void> removeAllDrafts() async {
    return _appDB.draftsDao.deleteAllDrafts();
  }

  @override
  Future<List<Listed>> fetchListeds() async {
    return _appDB.listedsDao.fetchListeds();
  }

  @override
  Future<List<ListedExt>> fetchListedExts() async {
    final Stream<List<ListedExt>> streams = _appDB.listedsDao.fetchListedExts();
    return await streams.first;
  }

  @override
  Future<void> removeListed(Listed listed) async {
    return _appDB.listedsDao.deleteListed(listed);
  }

  @override
  Future<void> saveListed(Listed listed) async {
    return _appDB.listedsDao.insertListed(listed);
  }

  @override
  Future<void> removeAllListeds() async {
    return _appDB.listedsDao.deleteAllListeds();
  }

  @override
  Future<List<Search>> fetchSearches() async {
    return _appDB.searchesDao.fetchSearches();
  }

  @override
  Future<void> removeSearch(Search search) async {
    return _appDB.searchesDao.deleteSearch(search);
  }

  @override
  Future<void> saveSearch(Search search) async {
    return _appDB.searchesDao.insertSearch(search);
  }

  @override
  Future<void> removeAllSearches() async {
    return _appDB.searchesDao.deleteAllSearches();
  }

  @override
  Future<List<History>> fetchHistories() async {
    return _appDB.historiesDao.fetchHistories();
  }

  @override
  Future<List<HistoryExt>> fetchHistoryExts() async {
    final Stream<List<HistoryExt>> streams =
        _appDB.historiesDao.fetchHistoryExts();
    return await streams.first;
  }

  @override
  Future<void> removeHistory(History history) async {
    return _appDB.historiesDao.deleteHistory(history);
  }

  @override
  Future<void> saveHistory(History history) async {
    return _appDB.historiesDao.insertHistory(history);
  }

  @override
  Future<void> removeAllHistories() async {
    return _appDB.historiesDao.deleteAllHistories();
  }
}
