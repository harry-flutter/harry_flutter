import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SettingsModule {
  @preResolve
  Future<SharedPreferences> get prefs async {
    return await SharedPreferences.getInstance();
  }
}
