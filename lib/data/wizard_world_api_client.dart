import 'package:dio/dio.dart';
import 'package:harry_flutter/application/bloc/harry_collections_bloc.dart';
import 'package:injectable/injectable.dart';

import '../application/injection_module/injection_container.dart';
import 'models/elixir.dart';
import 'models/house.dart';

class ElixirsRequestFailure implements Exception {}

List<Elixir> sortElixirsByName(List<Elixir> list, SortOrderTypes orderType) {
  list.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
  if (orderType == SortOrderTypes.desc) {
    return list.reversed.toList();
  }
  return list;
}

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

  Future<List<Elixir>> fetchPartElixirs(String? lastId, int count, SortOrderTypes orderType) async {
    try {
      var elixirs = <Elixir>[];
      final response = await _dio.get<List<dynamic>>(_elixirsUrl);

      if (response.statusCode == 200) {
        for (final v in response.data!) {
          elixirs.add(Elixir.fromJson(v));
        }

        final sortedElixirs = sortElixirsByName(elixirs, orderType);

        if (lastId != null) {
          final index = sortedElixirs.indexWhere((element) => element.id == lastId);
          if (index != -1) {
            return sortedElixirs.sublist(index + 1, (index + 1) + count);
          }
        }
        return sortedElixirs.sublist(0, count);
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
