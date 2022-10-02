import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../application/injection_module/injection_container.dart';
import 'models/elixir.dart';
import 'models/house.dart';

class ElixirsRequestFailure implements Exception {}

@injectable
class WizardWorldApiClient {
  final _dio = sl<Dio>();
  static const _elixirsUrl = '/Elixirs';
  static const _housesUrl = '/Houses';

  Future<List<Elixir>> fetchAllElixirs() async {
    try {
      final response = await _dio.get<List<dynamic>>(_elixirsUrl);
      var elixirs = <Elixir>[];
      if (response.statusCode == 200) {
        for (final v in response.data!) {
          elixirs.add(Elixir.fromJson(v));
        }
        return elixirs;
      } else {
        throw ElixirsRequestFailure();
      }
    } catch (error) {
      throw ElixirsRequestFailure();
    }
  }

  Future<List<House>> fetchAllHouses() async {
    try {
      final response = await _dio.get<List<dynamic>>(_housesUrl);
      var houses = <House>[];
      if (response.statusCode == 200) {
        for (final v in response.data!) {
          houses.add(House.fromJson(v));
        }
        return houses;
      } else {
        throw ElixirsRequestFailure();
      }
    } catch (error) {
      throw ElixirsRequestFailure();
    }
  }
}
