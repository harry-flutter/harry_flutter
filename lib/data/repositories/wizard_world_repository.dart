import 'package:harry_flutter/application/bloc/harry_collections_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../application/injection_module/injection_container.dart';
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
}
