import 'package:froom/froom.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../models/edit.dart';

@dao
abstract class EditsDao {
  @Query('SELECT * FROM ${AppConstants.editsTable} WHERE rid = :rid')
  Future<Edit?> findEditById(int rid);

  @Query('SELECT * FROM ${AppConstants.editsTable}')
  Future<List<Edit>> fetchEdits();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEdit(Edit edit);

  @update
  Future<void> updateEdit(Edit edit);

  @delete
  Future<void> deleteEdit(Edit edit);

  @Query("DELETE FROM ${AppConstants.editsTable}")
  Future<void> deleteAllEdits();
}
