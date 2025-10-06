import 'package:froom/froom.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../models/song.dart';
import '../../../models/songext.dart';

@dao
abstract class SongsDao {
  @Query('SELECT * FROM ${AppConstants.songsTable} WHERE rid = :rid')
  Future<Song?> findSongById(int rid);

  @Query('SELECT * FROM ${AppConstants.songsTableViews}')
  Stream<List<SongExt>> fetchAllSongs();

  @Query('SELECT * FROM ${AppConstants.songsTableViews} WHERE book = :bid')
  Stream<List<SongExt>> fetchSongs(int bid);

  @Query('SELECT * FROM ${AppConstants.songsTableViews} WHERE liked = 1')
  Stream<List<SongExt>> fetchLikes();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSong(Song song);

  @Query(
    'UPDATE ${AppConstants.songsTable} '
    'SET title = :title, content = :content, liked = :liked, updated = :updated WHERE rid = :rid',
  )
  Future<void> updateSong(
    int rid,
    String title,
    String content,
    bool liked,
    String updated,
  );

  @Query(
    'UPDATE ${AppConstants.songsTable} '
    'SET title = :title, alias = :alias, content = :content WHERE songId = :songId',
  )
  Future<void> syncSong(
    int songId,
    String title,
    String alias,
    String content,
  );

  @delete
  Future<void> deleteSong(Song song);

  @Query("DELETE FROM ${AppConstants.songsTable}")
  Future<void> deleteAllSongs();
}
