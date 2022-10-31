import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/repositories/settings_repository.dart';

part 'user_auth_bloc.freezed.dart';
part 'user_auth_event.dart';
part 'user_auth_state.dart';

const validMailDomain = '@domain.com';
const validPassword = 'password';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final SettingsRepository settingsRepository;

  UserAuthBloc({
    required this.settingsRepository,
  }) : super(
          settingsRepository.getLogin() == ''
              ? const _Unauthorized()
              : _Authorized(
                  settingsRepository.getLogin(),
                ),
        ) {
    on<_SignIn>(_onSignIn);
    on<_Logout>(_onLogout);
  }

  Future<void> _onSignIn(_SignIn event, Emitter<UserAuthState> emit) async {
    final login = event.login;
    final password = event.password;

    await Future.delayed(const Duration(milliseconds: 500));

    if (login.endsWith(validMailDomain) && password == validPassword) {
      await settingsRepository.setLogin(login);
      emit(UserAuthState.authorized(login));
    } else {
      emit(const UserAuthState.unauthorized());

      Fluttertoast.showToast(
        msg: "Неверный логин или пароль",
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        fontSize: 18.0,
      );
    }
  }

  Future<void> _onLogout(_Logout event, Emitter emit) async {
    await Future.delayed(const Duration(milliseconds: 500));

    await settingsRepository.setLogin('');
    emit(const UserAuthState.unauthorized());
  }
}
