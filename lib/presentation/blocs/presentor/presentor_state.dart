part of 'presentor_bloc.dart';

@freezed
class PresentorState with _$PresentorState {
  const factory PresentorState.initial() = _PresentorState;

  const factory PresentorState.loaded(
    List<Tab> tabs,
    List<String> stanzas,
  ) = PresentorLoadedState;

  const factory PresentorState.progress() = PresentorProgressState;

  const factory PresentorState.success() = PresentorSuccessState;

  const factory PresentorState.liked(bool liked) = PresentorLikedState;

  const factory PresentorState.history() = PresentorHistoryState;

  const factory PresentorState.failure(String feedback) = PresentorFailureState;
}
