import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/harry_collections_bloc.dart';
import 'bloc/user_auth_bloc.dart';
import 'repository/wizard_world_repository.dart';
import 'routes/home_page.dart';
import 'routes/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required WizardWorldRepository wizardWorldRepository})
      : _wizardWorldRepository = wizardWorldRepository,
        super(key: key);

  final WizardWorldRepository _wizardWorldRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserAuthBloc>(create: (BuildContext context) => UserAuthBloc()),
        BlocProvider<HarryCollectionsBloc>(
          create: (BuildContext context) => HarryCollectionsBloc(wizardWorldRepository: _wizardWorldRepository)
            ..add(const HarryCollectionsEvent.bootstrap()),
        ),
      ],
      child: MaterialApp(
        title: 'Harry Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<UserAuthBloc, UserAuthState>(
          builder: (context, state) {
            print(state);
            return state.maybeMap(orElse: () {
              return const LoginPage();
            }, authorized: (login) {
              return const HomePage();
            });
          },
        ),
      ),
    );
  }
}
