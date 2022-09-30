import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_auth_bloc.freezed.dart';
part 'user_auth_event.dart';
part 'user_auth_state.dart';

const demoDomain = '@domain.com';
const demoPassword = 'password';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final Box<dynamic> authBox;

  UserAuthBloc({
    required this.authBox,
  }) : super(authBox.get('login', defaultValue: '') == '' ? const _Unauthorized() : _Authorized(authBox.get('login'))) {
    on<_SignIn>(_onSignIn);
    on<_Logout>(_onLogout);
  }

  Future<void> _onSignIn(_SignIn event, Emitter<UserAuthState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final login = event.login;
    final password = event.password;
    if (login.endsWith(demoDomain) && password == demoPassword) {
      await authBox.put('login', login);
      emit(UserAuthState.authorized(login));
    } else {
      emit(const UserAuthState.unauthorized());
    }
  }

  Future<void> _onLogout(_Logout event, Emitter emit) async {
    await authBox.put('login', '');
    await Future.delayed(const Duration(milliseconds: 500));

    emit(const UserAuthState.unauthorized());
  }
}
