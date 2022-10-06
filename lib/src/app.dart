import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/injection_module/injection_container.dart';
import '../application/navigation/app_router.gr.dart';
import 'bloc/harry_collections_bloc.dart';
import 'bloc/user_auth_bloc.dart';
import 'repository/wizard_world_repository.dart';
import 'routes/login_page.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key, required WizardWorldRepository wizardWorldRepository})
      : _wizardWorldRepository = wizardWorldRepository,
        super(key: key);

  final WizardWorldRepository _wizardWorldRepository;

  final _appRouter = sl<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _wizardWorldRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserAuthBloc>(
              create: (BuildContext context) => UserAuthBloc()),
          BlocProvider<HarryCollectionsBloc>(
            create: (BuildContext context) => HarryCollectionsBloc(
                wizardWorldRepository: _wizardWorldRepository)
              ..add(const HarryCollectionsEvent.bootstrap()),
          )
        ],
        child: MaterialApp.router(
          title: 'Harry Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate(),
          builder: (context, router) {
            return BlocBuilder<UserAuthBloc, UserAuthState>(
              builder: (context, state) {
                print(state);
                return state.maybeMap(orElse: () {
                  return const LoginPage();
                }, authorized: (login) {
                  return router!;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
