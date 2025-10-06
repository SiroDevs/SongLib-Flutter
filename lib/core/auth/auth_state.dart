part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState._({
    @Default(AuthStatus.unauthenticated) AuthStatus status,
  }) = _AuthState;
  
  @override
  AuthStatus get status => AuthStatus.unauthenticated;
}

extension XAuthState on AuthState {
  static AuthState unverified() => AuthState._(
        status: AuthStatus.unverified,
      );
  static AuthState authenticated() => AuthState._(
        status: AuthStatus.authenticated,
      );
  static AuthState unauthenticated() => AuthState._(
        status: AuthStatus.unauthenticated,
      );
}
