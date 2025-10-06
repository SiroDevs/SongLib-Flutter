part of 'main_bloc.dart';

@freezed
sealed class MainEvent with _$MainEvent {
  const factory MainEvent.fetch() = FetchData;

  const factory MainEvent.sync() = SyncData;

  const factory MainEvent.filter(Book book) = FilterData;
  
  const factory MainEvent.reset() = ResetData;
  
}
