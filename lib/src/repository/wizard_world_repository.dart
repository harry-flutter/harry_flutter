import '../models/elixir.dart';
import '../wizard_world_api_client.dart';

class WizardWorldRepository {
  WizardWorldRepository({WizardWorldApiClient? wizardWorldApiClient})
      : _wizardWorldApiClient = wizardWorldApiClient ?? WizardWorldApiClient();

  final WizardWorldApiClient _wizardWorldApiClient;

  Future<List<Elixir>> getElixirs() async {
    return _wizardWorldApiClient.getElixirs();
  }
}
