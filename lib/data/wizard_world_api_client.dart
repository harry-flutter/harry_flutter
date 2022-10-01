import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../application/injection_module/injection_container.dart';
import 'models/elixir.dart';

class ElixirsRequestFailure implements Exception {}

@injectable
class WizardWorldApiClient {
  final _dio = sl<Dio>();
  static const _elixirsUrl = '/Elixirs';

  Future<List<Elixir>> getElixirs() async {
    try {
      final response = await _dio.get<List<dynamic>>(_elixirsUrl);
      var elixirs = <Elixir>[];
      if (response.statusCode == 200) {
        for (final v in response.data as List<dynamic>) {
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
}
