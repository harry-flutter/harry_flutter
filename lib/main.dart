import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'application/injection_module/injection_container.dart';
import 'data/repository/wizard_world_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  final authBox = await Hive.openBox('auth');

  runApp(
    MyApp(authBox: authBox, wizardWorldRepository: WizardWorldRepository()),
  );
}
