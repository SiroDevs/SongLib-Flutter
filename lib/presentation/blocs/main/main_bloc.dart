import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/di/injectable.dart';
import '../../../data/repositories/database_repository.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/pref_repository.dart';
import '../../../domain/repositories/sync_repository.dart';
import '../../../core/utils/app_util.dart';

part 'main_event.dart';
part 'main_state.dart';

part 'main_bloc.freezed.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const _MainState()) {
    on<SyncData>(_onSyncData);
    on<FetchData>(_onFetchData);
    on<FilterData>(_onFilterData);
    on<ResetData>(_onResetData);
  }

  final _syncRepo = SyncRepository();
  final _prefRepo = getIt<PrefRepository>();
  final _dbRepo = getIt<DatabaseRepository>();

  Future<void> _onSyncData(
    SyncData event,
    Emitter<MainState> emit,
  ) async {
    try {
      await _syncRepo.syncData();
      var books = await _dbRepo.fetchBooks();
      var songs = await _dbRepo.fetchSongs();
      emit(DataSyncedState(books, songs));
    } catch (e, stackTrace) {
      logger("Error log: $e\n$stackTrace");
      emit(LoadedState());
    }
  }

  Future<void> _onFetchData(
    FetchData event,
    Emitter<MainState> emit,
  ) async {
    emit(FetchingState());
    try {
      var books = await _dbRepo.fetchBooks();
      var songs = await _dbRepo.fetchSongs();
      emit(DataFetchedState(books, songs));
    } catch (e) {
      logger('Unable to: $e');
      emit(FailureState('Unable to fetch songs'));
    }
  }

  Future<void> _onFilterData(
    FilterData event,
    Emitter<MainState> emit,
  ) async {
    emit(FilteringState());
    try {
      var songs = await _dbRepo.fetchSongs(bid: event.book.bookId!);
      var likes = await _dbRepo.fetchLikes();
      emit(FilteredState(event.book, songs, likes));
    } catch (e) {
      logger('Unable to: $e');
      emit(LoadedState());
    }
  }

  Future<void> _onResetData(
    ResetData event,
    Emitter<MainState> emit,
  ) async {
    emit(FetchingState());
    try {
      await _dbRepo.removeAllBooks();
      await _dbRepo.removeAllSongs();
      _prefRepo.clearData();
      emit(ResettedState());
    } catch (e) {
      logger('Unable to: $e');
      emit(LoadedState());
    }
  }
}
