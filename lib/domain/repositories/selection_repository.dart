import 'dart:async';

import 'package:http/http.dart';

import '../../data/sources/remote/selection_client.dart';


class SelectionRepository {
  final _selectionClient = SelectionClient();

  /// Fetch all books
  Future<Response> getBooks() async => await _selectionClient.getBooks();

  /// Fetch  all songs
  Future<Response> getSongs() async => await _selectionClient.getSongs();

  /// Fetch songs by book ids
  Future<Response> getSongsByBooks(String bookIds) async {
    return await _selectionClient.getSongsByBooks(bookIds);
  }
}
