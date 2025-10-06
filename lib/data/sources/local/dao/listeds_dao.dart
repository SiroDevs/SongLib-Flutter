import 'package:froom/froom.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../models/listed.dart';
import '../../../models/listedext.dart';

@dao
abstract class ListedsDao {
  @Query('SELECT * FROM ${AppConstants.listedsTable}')
  Future<List<Listed>> fetchListeds();

  @Query('SELECT * FROM ${AppConstants.listedsTableViews}')
  Stream<List<ListedExt>> fetchListedExts();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertListed(Listed listed);

  @delete
  Future<void> deleteListed(Listed listed);

  @Query("DELETE FROM ${AppConstants.listedsTable}")
  Future<void> deleteAllListeds();
}
