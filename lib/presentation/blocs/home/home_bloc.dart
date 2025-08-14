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

part 'home_event.dart';
part 'home_state.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const _HomeState()) {
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
    Emitter<HomeState> emit,
  ) async {
    try {
      await _syncRepo.syncData();
      var books = await _dbRepo.fetchBooks();
      var songs = await _dbRepo.fetchSongs();
      emit(HomeDataSyncedState(books, songs));
    } catch (e, stackTrace) {
      logger("Error log: $e\n$stackTrace");
      emit(HomeLoadedState());
    }
  }

  Future<void> _onFetchData(
    FetchData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeFetchingState());
    try {
      var books = await _dbRepo.fetchBooks();
      var songs = await _dbRepo.fetchSongs();
      emit(HomeDataFetchedState(books, songs));
    } catch (e) {
      logger('Unable to: $e');
      emit(HomeFailureState('Unable to fetch songs'));
    }
  }

  Future<void> _onFilterData(
    FilterData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeFilteringState());
    try {
      var songs = await _dbRepo.fetchSongs(bid: event.book.bookId!);
      var likes = await _dbRepo.fetchLikes();
      emit(HomeFilteredState(event.book, songs, likes));
    } catch (e) {
      logger('Unable to: $e');
      emit(HomeLoadedState());
    }
  }

  Future<void> _onResetData(
    ResetData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeFetchingState());
    try {
      await _dbRepo.removeAllBooks();
      await _dbRepo.removeAllSongs();
      _prefRepo.clearData();
      emit(HomeResettedState());
    } catch (e) {
      logger('Unable to: $e');
      emit(HomeLoadedState());
    }
  }
}
