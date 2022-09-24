part of 'user_auth_bloc.dart';

@freezed
class UserAuthState with _$UserAuthState {
  const factory UserAuthState.unauthorized() = _Unauthorized;
  const factory UserAuthState.authorized(String login) = _Authorized;
}
