part of 'step2_bloc.dart';

@freezed
class Step2State with _$Step2State {
  const factory Step2State.initial() = _Step2State;

  const factory Step2State.loaded() = Step2LoadedState;

  const factory Step2State.progress() = Step2ProgressState;

  const factory Step2State.success() = Step2SuccessState;

  const factory Step2State.fetched(List<Song> songs) = Step2FetchedState;

  const factory Step2State.saving(int progress, String feedback) = Step2SavingState;

  const factory Step2State.saved() = Step2SavedState;

  const factory Step2State.failure(String feedback) = Step2FailureState;

  const factory Step2State.noInternet() = Step2NoInternetState;
}
