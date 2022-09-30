import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'models/elixir.dart';

class ElixirsRequestFailure implements Exception {}

@injectable
class WizardWorldApiClient {
  WizardWorldApiClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: dotenv.get('BASE_URL', fallback: ''),
              ),
            );

  final Dio _dio;

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
