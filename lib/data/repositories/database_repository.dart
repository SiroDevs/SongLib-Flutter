import '../models/models.dart';

abstract class DatabaseRepository {
  Future<List<Book>> fetchBooks();

  Future<void> saveBook(Book book);

  Future<void> removeBook(Book book);

  Future<void> removeAllBooks();

  Future<List<SongExt>> fetchSongs({int bid = 0});

  Future<List<SongExt>> fetchLikes();

  Future<Song?> findSongById(int rid);

  Future<void> saveSong(Song song);

  Future<void> updateSong(
    int rid,
    String title,
    String content,
    bool liked,
    String updated,
  );

  Future<void> syncSong(
    int rid,
    String title,
    String content,
    String updated,
  );

  Future<void> removeSong(Song song);

  Future<void> removeAllSongs();

  Future<List<Draft>> fetchDrafts();

  Future<void> saveDraft(Draft draft);

  Future<void> removeDraft(Draft draft);

  Future<void> removeAllDrafts();

  Future<List<Edit>> fetchEdits();

  Future<void> saveEdit(Edit edit);

  Future<void> removeEdit(Edit edit);

  Future<void> removeAllEdits();

  Future<List<Listed>> fetchListeds();

  Future<List<ListedExt>> fetchListedExts();

  Future<void> saveListed(Listed listed);

  Future<void> removeListed(Listed listed);

  Future<void> removeAllListeds();

  Future<List<Search>> fetchSearches();

  Future<void> saveSearch(Search search);

  Future<void> removeSearch(Search search);

  Future<void> removeAllSearches();

  Future<List<History>> fetchHistories();

  Future<List<HistoryExt>> fetchHistoryExts();

  Future<void> saveHistory(History history);

  Future<void> removeHistory(History history);

  Future<void> removeAllHistories();
}
