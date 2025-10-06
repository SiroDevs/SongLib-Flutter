part of 'main_bloc.dart';

@freezed
class MainState with _$MainState {
  const factory MainState.initial() = _MainState;

  const factory MainState.loaded() = LoadedState;

  const factory MainState.fetched(
    List<Book> books,
    List<SongExt> songs,
  ) = DataFetchedState;

  const factory MainState.synced(
    List<Book> books,
    List<SongExt> songs,
  ) = DataSyncedState;

  const factory MainState.filtered(
    Book book,
    List<SongExt> songs,
    List<SongExt> likes,
  ) = FilteredState;

  const factory MainState.fetching() = FetchingState;

  const factory MainState.filtering() = FilteringState;

  const factory MainState.success() = SuccessState;

  const factory MainState.reset() = ResettedState;

  const factory MainState.failure(String feedback) = FailureState;

  const factory MainState.noInternet() = NoInternetState;
  
  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    throw UnimplementedError();
  }
  
  @override
  DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style}) {
    throw UnimplementedError();
  }
  
  @override
  String toStringDeep({String prefixLineOne = '', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65}) {
    throw UnimplementedError();
  }
  
  @override
  String toStringShallow({String joiner = ', ', DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    throw UnimplementedError();
  }
  
  @override
  String toStringShort() {
    throw UnimplementedError();
  }
}
