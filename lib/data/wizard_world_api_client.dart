import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../application/bloc/harry_collections_bloc.dart';
import '../application/injection_module/injection_container.dart';
import 'models/elixir.dart';
import 'models/house.dart';
import 'models/ingredient.dart';
import 'models/wizard.dart';

class DataRequestFailure implements Exception {}

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
  static const _ingredientsUrl = '/Ingredients';
  static const _wizardsUrl = '/Wizards';

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
        throw DataRequestFailure();
      }
    } catch (error) {
      throw DataRequestFailure();
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
        throw DataRequestFailure();
      }
    } catch (error) {
      throw DataRequestFailure();
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
        throw DataRequestFailure();
      }
    } catch (error) {
      throw DataRequestFailure();
    }
  }

  Future<List<Ingredient>> fetchAllIngredients() async {
    try {
      final response = await _dio.get<List<dynamic>>(_ingredientsUrl);
      var ingredients = <Ingredient>[];
      if (response.statusCode == 200) {
        for (final v in response.data!) {
          ingredients.add(Ingredient.fromJson(v));
        }
        return ingredients;
      } else {
        throw DataRequestFailure();
      }
    } catch (error) {
      throw DataRequestFailure();
    }
  }

  Future<List<Wizard>> fetchAllWizards() async {
    try {
      final response = await _dio.get<List<dynamic>>(_wizardsUrl);
      var wizards = <Wizard>[];
      if (response.statusCode == 200) {
        for (final v in response.data!) {
          wizards.add(Wizard.fromJson(v));
        }
        return wizards;
      } else {
        throw DataRequestFailure();
      }
    } catch (error) {
      throw DataRequestFailure();
    }
  }
}
