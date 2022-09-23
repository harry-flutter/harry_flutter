import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/harry_collections_bloc.dart';
import 'repository/wizard_world_repository.dart';
import 'routes/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required WizardWorldRepository wizardWorldRepository})
      : _wizardWorldRepository = wizardWorldRepository,
        super(key: key);

  final WizardWorldRepository _wizardWorldRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _wizardWorldRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HarryCollectionsBloc>(
            create: (BuildContext context) => HarryCollectionsBloc(wizardWorldRepository: _wizardWorldRepository)
              ..add(const HarryCollectionsEvent.bootstrap()),
          )
        ],
        child: MaterialApp(
          title: 'Harry Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(title: 'Harry Flutter'),
        ),
      ),
    );
  }
}
