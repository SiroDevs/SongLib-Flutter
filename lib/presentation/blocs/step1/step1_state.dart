part of 'step1_bloc.dart';

@freezed
class Step1State with _$Step1State {
  const factory Step1State.initial() = _Step1State;

  const factory Step1State.loaded() = Step1LoadedState;

  const factory Step1State.progress() = Step1ProgressState;

  const factory Step1State.success() = Step1SuccessState;

  const factory Step1State.fetched(
    String selectedBooksIds,
    List<Book> books,
    List<Selectable<Book>> booksListing,
  ) = Step1FetchedState;

  const factory Step1State.saved(String selectedBooks) = Step1SavedState;

  const factory Step1State.failure(String feedback) = Step1FailureState;

  const factory Step1State.noInternet() = Step1NoInternetState;
}
