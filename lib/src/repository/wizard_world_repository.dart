import 'package:injectable/injectable.dart';

import '../models/elixir.dart';
import '../wizard_world_api_client.dart';

@injectable
class WizardWorldRepository {
  WizardWorldRepository({WizardWorldApiClient? wizardWorldApiClient})
      : _wizardWorldApiClient = wizardWorldApiClient ?? WizardWorldApiClient();

  final WizardWorldApiClient _wizardWorldApiClient;

  Future<List<Elixir>> getElixirs() async {
    return _wizardWorldApiClient.getElixirs();
  }
}
