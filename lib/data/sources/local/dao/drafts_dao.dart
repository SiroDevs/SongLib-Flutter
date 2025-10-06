import 'package:froom/froom.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../models/draft.dart';

@dao
abstract class DraftsDao {
  @Query('SELECT * FROM ${AppConstants.draftsTable} WHERE rid = :rid')
  Future<Draft?> findDraftById(int rid);

  @Query('SELECT * FROM ${AppConstants.draftsTable}')
  Future<List<Draft>> fetchDrafts();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDraft(Draft draft);

  @update
  Future<void> updateDraft(Draft draft);

  @delete
  Future<void> deleteDraft(Draft draft);

  @Query("DELETE FROM ${AppConstants.draftsTable}")
  Future<void> deleteAllDrafts();
}
