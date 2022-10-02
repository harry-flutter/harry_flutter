import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/injection_module/injection_container.dart';

@injectable
class SettingsRepository {
  final prefs = sl<SharedPreferences>();

  static const favoriteElixirsKey = 'favorite_elixirs';
  static const favoriteHousesKey = 'favorite_houses';

  String getLogin() {
    return prefs.getString('login') ?? '';
  }

  Future<void> setLogin(String value) async {
    await prefs.setString('login', value);
  }

  List<String> getFavoriteElixirs() {
    return prefs.getStringList(favoriteElixirsKey) ?? [];
  }

  Future<void> clearFavoriteElixirs() async {
    _clearList(favoriteElixirsKey);
  }

  Future<void> addFavoriteElixir(String value) async {
    _addToList(favoriteElixirsKey, value);
  }

  Future<void> removeFavoriteElixir(String value) async {
    _removeFromList(favoriteElixirsKey, value);
  }

  List<String> getFavoriteHouses() {
    return prefs.getStringList(favoriteHousesKey) ?? [];
  }

  Future<void> clearFavoriteHouses() async {
    _clearList(favoriteHousesKey);
  }

  Future<void> addFavoriteHouse(String value) async {
    _addToList(favoriteHousesKey, value);
  }

  Future<void> removeFavoriteHouse(String value) async {
    _removeFromList(favoriteHousesKey, value);
  }

  Future<void> _clearList(String key) async {
    await prefs.remove(key);
  }

  Future<void> _addToList(String key, String value) async {
    final current = prefs.getStringList(key) ?? [];
    if (!current.contains(value)) {
      await prefs.setStringList(key, <String>[...current, value]);
    }
  }

  Future<void> _removeFromList(String key, String value) async {
    final current = prefs.getStringList(key) ?? [];
    if (current.contains(value)) {
      current.removeWhere((element) => element == value);
      await prefs.setStringList(key, <String>[...current]);
    }
  }
}
