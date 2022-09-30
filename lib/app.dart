import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../application/bloc/harry_collections_bloc.dart';
import '../application/bloc/user_auth_bloc.dart';
import '../application/injection_module/injection_container.dart';
import '../application/navigation/app_router.gr.dart';
import 'data/repository/wizard_world_repository.dart';
import 'ui/routes/login_page.dart';

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.authBox,
    required this.wizardWorldRepository,
  }) : super(key: key);

  final Box<dynamic> authBox;
  final WizardWorldRepository wizardWorldRepository;

  final _appRouter = sl<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: wizardWorldRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserAuthBloc>(create: (BuildContext context) => UserAuthBloc(authBox: authBox)),
          BlocProvider<HarryCollectionsBloc>(
            create: (BuildContext context) => HarryCollectionsBloc(wizardWorldRepository: wizardWorldRepository)
              ..add(const HarryCollectionsEvent.bootstrap()),
          )
        ],
        child: MaterialApp.router(
          title: 'Harry Flutter',
          theme: ThemeData.light(),
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          builder: (context, router) {
            return BlocBuilder<UserAuthBloc, UserAuthState>(
              builder: (context, state) {
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
