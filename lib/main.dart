import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application/injection_module/injection_container.dart';
import 'src/app.dart';
import 'src/repository/wizard_world_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await dotenv.load(fileName: ".env");

  runApp(
    MyApp(authenticated: true, wizardWorldRepository: WizardWorldRepository()),
  );
}
