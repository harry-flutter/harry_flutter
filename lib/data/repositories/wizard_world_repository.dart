import 'package:injectable/injectable.dart';

import '../../application/bloc/harry_collections_bloc.dart';
import '../../application/injection_module/injection_container.dart';
import '../models/ingredient.dart';
import '../models/wizard.dart';
import '../models/elixir.dart';
import '../models/house.dart';
import '../wizard_world_api_client.dart';

@injectable
class WizardWorldRepository {
  final WizardWorldApiClient _wizardWorldApiClient = sl<WizardWorldApiClient>();

  Future<List<Elixir>> fetchElixirs({
    String? lastId,
    required int count,
    required SortOrderTypes orderType,
  }) async {
    return _wizardWorldApiClient.fetchPartElixirs(lastId, count, orderType);
  }

  Future<List<House>> fetchAllHouses() async {
    return _wizardWorldApiClient.fetchAllHouses();
  }

  Future<List<Ingredient>> fetchAllIngredients() async {
    return _wizardWorldApiClient.fetchAllIngredients();
  }

  Future<List<Wizard>> fetchAllWizards() async {
    return _wizardWorldApiClient.fetchAllWizards();
  }
}
