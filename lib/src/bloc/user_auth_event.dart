part of 'user_auth_bloc.dart';

@freezed
class UserAuthEvent with _$UserAuthEvent {
  const factory UserAuthEvent.signIn(String login, String password) = _SignIn;
  const factory UserAuthEvent.logout() = _Logout;
}
