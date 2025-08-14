import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/app_util.dart';
import '../../../core/utils/date_util.dart';
import '../../../data/models/history.dart';
import '../../../data/models/songext.dart';
import '../../../data/repositories/database_repository.dart';
import '../../../core/di/injectable.dart';
import '../../screens/presentor/common/presentor_utils.dart';

part 'presentor_event.dart';
part 'presentor_state.dart';

part 'presentor_bloc.freezed.dart';

class PresentorBloc extends Bloc<PresentorEvent, PresentorState> {
  PresentorBloc() : super(const _PresentorState()) {
    on<LoadSong>(_onLoadSong);
    on<LikeSong>(_onLikeSong);
    on<SaveHistory>(_onSaveHistory);
  }

  final _dbRepo = getIt<DatabaseRepository>();

  Future<void> _onLoadSong(
    LoadSong event,
    Emitter<PresentorState> emit,
  ) async {
    emit(PresentorProgressState());
    var presentor = await loadSong(event.song);
    emit(PresentorLoadedState(
      presentor.songVerses,
      presentor.widgetTabs,
      presentor.widgetContent,
    ));
  }

  Future<void> _onLikeSong(
    LikeSong event,
    Emitter<PresentorState> emit,
  ) async {
    try {
      await _dbRepo.updateSong(
        event.song.rid,
        event.song.title,
        event.song.content,
        !event.song.liked,
        getIso8601Date(),
      );
    } catch (e) {
      logger('Unable to update song: $e');
    }

    emit(PresentorLikedState(!event.song.liked));
  }

  Future<void> _onSaveHistory(
    SaveHistory event,
    Emitter<PresentorState> emit,
  ) async {
    await _dbRepo.saveHistory(
      History(song: event.song.rid, created: getCurrentDate()),
    );
    emit(PresentorHistoryState());
  }
}
