import 'package:injectable/injectable.dart';

import '../../application/injection_module/injection_container.dart';
import '../models/elixir.dart';
import '../wizard_world_api_client.dart';

@injectable
class WizardWorldRepository {
  final WizardWorldApiClient _wizardWorldApiClient = sl<WizardWorldApiClient>();

  Future<List<Elixir>> getElixirs() async {
    return _wizardWorldApiClient.getElixirs();
  }
}
