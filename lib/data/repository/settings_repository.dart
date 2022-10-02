import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../application/auth_module/auth_module.dart';
import '../../application/injection_module/injection_container.dart';

@injectable
class SettingsRepository {
  SettingsRepository();

  final prefs = sl<SharedPreferences>();

  // Future<String> getLogin() async {
  //   return (await authBox.get('login', defaultValue: '')) ?? '';
  // }

  String getLogin() {
    return prefs.getString('login') ?? '';
  }

  Future<void> setLogin(String value) async {
    await prefs.setString('login', value);
  }
}
