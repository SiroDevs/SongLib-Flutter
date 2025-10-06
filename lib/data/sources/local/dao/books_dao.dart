import 'package:froom/froom.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../models/book.dart';

@dao
abstract class BooksDao {
  @Query('SELECT * FROM ${AppConstants.booksTable} WHERE rid = :rid')
  Future<Book?> findBookById(int rid);

  @Query('SELECT * FROM ${AppConstants.booksTable}')
  Future<List<Book>> fetchBooks();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBook(Book book);

  @update
  Future<void> updateBook(Book book);

  @delete
  Future<void> deleteBook(Book book);

  @Query("DELETE FROM ${AppConstants.booksTable}")
  Future<void> deleteAllBooks();
}
